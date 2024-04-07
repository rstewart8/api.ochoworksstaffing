<?php
error_reporting( E_ALL );
ini_set('display_errors', 1);

$logger         = new Logger(); 
$db             = new Database($logger); 

$data = json_decode(file_get_contents('php://input'), true);
$sysAdminStatus = explode(',',SYSADMINSTATUS);

function isValidPassword(&$res,$password,$confirm) {
	if ($password != $confirm) {
		$res['status'] = 'fail';
		$res['msg'] = 'Passwords does not match.';
		return false;
	} elseif (strlen($password) < PASSWORDMINLENGTH) {
		$res['status'] = 'fail';
		$res['msg'] = 'Password is less than '.PASSWORDMINLENGTH.' characters.';
		return false;
	} elseif (strlen($password) > PASSWORDMAXLENGTH) {
		$res['status'] = 'fail';
		$res['msg'] = 'Password is greater than '.PASSWORDMAXLENGTH.' characters.';
		return false;
	} elseif (!preg_match('/^(?=.*[\d])(?=.*[A-Z])(?=.*[a-z])(?=.*[!@#$%^&*])[\w!@#$%^&*]{8,}$/', $password)) {
		$res['status'] = 'fail';
		$res['msg'] = 'Invalid password.';
		return false;
	}
	return true;
}

function isValidUsername(&$res,$db,$username,$userId=null){
	if (strlen($username) < USERMINLENGTH) {
		$res['status'] = 'fail';
		$res['msg'] = 'Username is less than '.USERMAXLENGTH.' characters.';
		return false;
	} elseif (strlen($username) > USERMAXLENGTH) {
		$res['status'] = 'fail';
		$res['msg'] = 'Username is greater than '.USERMAXLENGTH.' characters.';
		return false;
	} elseif (!preg_match('/^[$A-Z_][0-9A-Z_$]*$/i', $username)) {
		$res['status'] = 'fail';
		$res['msg'] = 'Invalid username.';
		return false;
	}

	$qry = "SELECT id FROM system_users WHERE username = ?;";
	$values = [$username];

	if ($userId != null) {
		$qry = "SELECT id FROM system_users WHERE username = ? AND id != ?;";
		$values = [$username,$userId];
	}

	$rows = $db->query($qry,$values);

	if (count($rows) > 0) {
		$res['status'] = 'fail';
		$res['msg'] = 'Username already exists.';
		return false;
	}
	return true;
}

function isValidStatus(&$res,$status,$statuss) {
	if (!in_array($status, $statuss)) {
		$res['status'] = 'fail';
		$res['msg'] = 'Invalid status.';
		return false;
	}
	return true;
}

function isLastActive(&$res,$db,$userId) {
	$qry = "SELECT * FROM system_users WHERE status = 'active' AND id != ? LIMIT 1;";
	$values = [$userId];

	$row = $db->query($qry,$values);
	if (count($row) < 1) {
	 	$res['status'] = 'fail';
		$res['msg'] = 'This is last active user.';
		return true;
	}
	return false;
}

if (count($data) > 0) {
	$res = [
		'status' => 'ok',
		'msg' => [],
		'data' => []
	];

	$statuss = explode(',',SYSADMINSTATUS);

	if ($data['which'] == 'create' 
		&& isset($data['username'])
		&& isset($data['status'])
		&& isset($data['password'])
		&& isset($data['confirm'])) {

		$username = $data['username'];
		$status = strtolower($data['status']);
		$password = $data['password'];
		$confirm = ($data['confirm']);

		if (isValidPassword($res,$password,$confirm)
			&& isValidUsername($res,$db,$username)
			&& isValidStatus($res,$status,$statuss)) {

			$password = md5($password);

			$qry = "INSERT INTO system_users (username,status,password,created) VALUES (?,?,?,NOW());";
			$values = [$username,$status,$password];
			
			$userId = $db->insert($qry,$values);

			if ($userId != null) {
				$res['data'] = $userId;
			} else {
				$res['status'] = 'failed';
			}
		}

	} elseif ($data['which'] == 'update' 
		&& isset($data['username'])
		&& isset($data['status'])
		&& isset($data['id'])) { 

		$username = $data['username'];
		$status = strtolower($data['status']);
		$userId = $data['id'];

		if (isValidUsername($res,$db,$username,$userId)
			&& isValidStatus($res,$status,$statuss)) {

			$values = [$username,$status,$userId];
			$qry = "UPDATE system_users SET username = ?, status = ?, modified = NOW() WHERE id = ?;";

			if (isset($data['password'])
				&& $data['password'] != ''
				&& isset($data['confirm'])
				&& $data['confirm'] != '') {

				$password = $data['password'];
				$confirm = ($data['confirm']);
				
				if (isValidPassword($res,$password,$confirm)) {

					$password = md5($password);
					$values = [$username,$status,$password,$userId];
					$qry = "UPDATE system_users SET username = ?, status = ?, password = ?, modified = NOW() WHERE id = ?";
				}
			}

			if (
				($status != 'active' && !isLastActive($res,$db,$userId)) 
				|| $status == 'active') {
				$r = $db->update($qry,$values);
				$res['data'] = $r;
			}
		}

	} elseif ($data['which'] == 'deleteUser') {

		if (isset($data['id']) && $data['id'] != '') {
			$userId = $data['id'];

			if (!isLastActive($res,$db,$userId)) {
				$qry = "DELETE FROM system_users WHERE id = ?;";
				$values = [$userId];
				$db->query($qry,$values);
			}

		} else {
			$res['status'] = 'fail';
			$res['msg'] = 'Missing user id.';
		}
	} elseif ($data['which'] == 'logOut') {
		session_destroy();
	} else {
		$res['status'] = 'fail';
		$res['msg'] = 'Missing data.';
	}

	header("HTTP/1.1 200 OK");
	header('Content-type: application/json');
	echo json_encode($res);
    exit;
}

$qry = "SELECT id,username,status,created,modified FROM system_users WHERE status != 'deleted' ORDER BY username ASC;";
$values = [];
$rows = $db->query($qry,$values);

$data = [
	'users' => []
];

foreach ($rows as $row) {
	array_push($data['users'],$row);
}


// echo "users: <pre>".print_r($_SESSION,true)."</pre>";
?>
<!DOCTYPE html>
<html lang="en">

<head>

	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<meta name="description" content="">
	<meta name="author" content="">

	<title>PDQ-Api - Users</title>

	<!-- Bootstrap Core CSS -->
	<link href="css/bootstrap.min.css" rel="stylesheet">
	<link href="css/main.css" rel="stylesheet">

	<script type="text/javascript">
	    window.data= <?php echo json_encode($data); ?>;
	</script>

	<!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
	<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
	<!--[if lt IE 9]>
		<script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
		<script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
	<![endif]-->

</head>

<body 
	ng-app="app" 
	ng-controller="userCtrl" 
	ng-init="init('data')">

	<!-- ***** modal templates ***** -->
	<script type="text/ng-template" id="userForm.html">
		<div class="modal-header">
			<h3 class="modal-title" id="modal-title">Api User</h3>
		</div>
		<div class="modal-body" id="modal-body">
			<form name="userForm" novalidate>
				<div 
					class="form-group" 
					ng-class="{ 'has-error' : userForm.username.$invalid && !userForm.username.$pristine }">
					<label>Username</label>
					<input 
						type="text" 
						name="username" 
						class="form-control" 
						ng-model="user.username" 
						ng-minlength="<?= USERMINLENGTH ?>" 
						ng-maxlength="<?= USERMAXLENGTH ?>"
						ng-pattern="/^[$A-Z_][0-9A-Z_$]*$/i" 
						required>
					<p 
						ng-show="userForm.username.$error.minlength"
						class="help-block">
						Username is too short.
					</p>
					<p 
						ng-show="userForm.username.$error.maxlength"
						class="help-block">
						Username is too long.
					</p>
					<p 
						ng-show="userForm.username.$error.pattern 
						&& !userForm.username.$error.minlength 
						&& !userForm.username.$error.maxlength" 
						class="help-block">
						Invalid username.
					</p>
				</div>
				<div class="form-group">
					<select class="form-control" ng-model="user.status">
						<?php foreach ($sysAdminStatus as $status) { ?>
							<option value="<?= $status ?>"><?= $status ?></option>
						<?php } ?>
					</select>
				</div>	
				<div 
					class="form-group" 
					ng-class="{ 'has-error' : userForm.password.$invalid && !userForm.password.$pristine }">
					<label>Password</label>
					<input 
						ng-change="passwordChange(userForm)" 
						type="password" 
						name="password" 
						class="form-control" 
						ng-model="user.password" 
						ng-minlength="<?= PASSWORDMINLENGTH ?>" 
						ng-maxlength="<?= PASSWORDMAXLENGTH ?>"
						ng-pattern="/^(?=.*[\d])(?=.*[A-Z])(?=.*[a-z])(?=.*[!@#$%^&*])[\w!@#$%^&*]{<?= PASSWORDMINLENGTH ?>,}$/" 
						required>
					<p 
						ng-show="userForm.password.$error.minlength" 
						class="help-block">
						Password is too short.
					</p>
					<p 
						ng-show="userForm.password.$error.maxlength"
						class="help-block">
						Password is too long.
					</p>
					<p 
						ng-show="userForm.password.$error.pattern 
						&& !userForm.password.$error.minlength 
						&& !userForm.password.$error.maxlength" 
						class="help-block">
						Invalid password.
					</p>
				</div>
				<div 
					class="form-group" 
					ng-class="{ 'has-error' : userForm.passwordConfirm.$invalid && !userForm.passwordConfirm.$pristine }">
					<label>Confirm Password</label>
					<input  
						type="password" 
						name="passwordConfirm" 
						class="form-control" 
						ng-model="user.passwordConfirm" 
						ng-change="passwordChange(userForm)"
						required>
					<p 
						ng-show="userForm.passwordConfirm.$error.passwordmatch"
						class="help-block">
						Passwords do not match.
					</p>
			</form>
		</div>
		<div class="modal-footer">
			<button class="btn btn-primary" type="button" ng-click="save()" ng-disabled="!userForm.$valid">Save</button>
			<button class="btn btn-warning" type="button" ng-click="cancel()">Cancel</button>
		</div>
	</script>

	<script type="text/ng-template" id="editForm.html">
		<div class="modal-header">
			<h3 class="modal-title" id="modal-title">Api User</h3>
		</div>
		<div class="modal-body" id="modal-body">
			<form name="userForm" novalidate>
				<div 
					class="form-group" 
					ng-class="{ 'has-error' : userForm.username.$invalid && !userForm.username.$pristine }">
					<label>Username</label>
					<input 
						type="text" 
						name="username" 
						class="form-control" 
						ng-model="user.username" 
						ng-minlength="<?= USERMINLENGTH ?>" 
						ng-maxlength="<?= USERMAXLENGTH ?>"
						ng-pattern="/^[$A-Z_][0-9A-Z_$]*$/i" 
						required>
					<p 
						ng-show="userForm.username.$error.minlength"
						class="help-block">
						Username is too short.
					</p>
					<p 
						ng-show="userForm.username.$error.maxlength"
						class="help-block">
						Username is too long.
					</p>
					<p 
						ng-show="userForm.username.$error.pattern 
						&& !userForm.username.$error.minlength 
						&& !userForm.username.$error.maxlength" 
						class="help-block">
						Invalid username.
					</p>
				</div>
				<div class="form-group">
					<select class="form-control" ng-model="user.status">
						<?php foreach ($sysAdminStatus as $status) { ?>
							<option value="<?= $status ?>"><?= $status ?></option>
						<?php } ?>
					</select>
				</div>	
				<div 
					class="form-group" 
					ng-class="{ 'has-error' : userForm.password.$invalid && !userForm.password.$pristine }">
					<label>Password</label>
					<input 
						ng-change="passwordChange(userForm)" 
						type="password" 
						name="password" 
						class="form-control" 
						ng-model="user.password" 
						ng-minlength="<?= PASSWORDMINLENGTH ?>" 
						ng-maxlength="<?= PASSWORDMAXLENGTH ?>"
						ng-pattern="/^(?=.*[\d])(?=.*[A-Z])(?=.*[a-z])(?=.*[!@#$%^&*])[\w!@#$%^&*]{<?= PASSWORDMINLENGTH ?>,}$/">
					<p 
						ng-show="userForm.password.$error.minlength" 
						class="help-block">
						Password is too short.
					</p>
					<p 
						ng-show="userForm.password.$error.maxlength"
						class="help-block">
						Password is too long.
					</p>
					<p 
						ng-show="userForm.password.$error.pattern 
						&& !userForm.password.$error.minlength 
						&& !userForm.password.$error.maxlength" 
						class="help-block">
						Invalid password.
					</p>
				</div>
				<div 
					class="form-group" 
					ng-class="{ 'has-error' : userForm.passwordConfirm.$invalid && !userForm.passwordConfirm.$pristine }">
					<label>Confirm Password</label>
					<input  
						type="password" 
						name="passwordConfirm" 
						class="form-control" 
						ng-model="user.passwordConfirm" 
						ng-change="passwordChange(userForm)">
					<p 
						ng-show="userForm.passwordConfirm.$error.passwordmatch"
						class="help-block">
						Passwords do not match.
					</p>
			</form>
		</div>
		<div class="modal-footer">
			<button class="btn btn-primary" type="button" ng-click="save()" ng-disabled="!userForm.$valid">Save</button>
			<button class="btn btn-warning" type="button" ng-click="cancel()">Cancel</button>
		</div>
	</script>

	<!-- ***** modal templates end ***** -->

	<?php require(ROOT.'/pages/includes/header.php'); ?>

	<div class="container">
		<div class="row">
			<div class="col-xs-12 col-sm-6 text-right">
				<button 
					ng-click="open('userForm')" 
					type="button" 
					class="btn btn-success btn-xs"
					style="margin-top:8px;">
					Add User
				</button>
			</div>
		</div>
		<div class="row">
			<div class="col-xs-12 col-sm-8">
				<table class="table table-responsive">
					<thead>
						<tr>
							<th>User Name</th>
							<th>Status</th>
							<th>Created On</th>
							<th>Last Modified On</th>
							<th></th>
						</tr>
					</thead>
					<tbody>
						<tr ng-repeat="user in users">
							<td>{{user.username}}</td>
							<td>{{user.status}}</td>
							<td>{{user.created | date:'fullDate'}}</td>
							<td>{{user.modified | date:'fullDate'}}</td>
							<td>
								<button
									class="button btn-primary btn-xs"
									ng-click="edit('editForm',user)">
									Edit	
								</button>
							</td>
							<td>
								<button
									class="button btn-warning btn-xs"
									ng-click="deleteUser(user.id)">
									Delete	
								</button>
							</td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
	</div>

	<!-- jQuery Version 1.11.1 -->
	<script src="js/jquery.js"></script>
	<!-- <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.4.2/jquery.min.js"></script> -->

	<!-- Bootstrap Core JavaScript -->
	<script src="js/bootstrap.min.js"></script>

	<!-- angular Version 1.6.9 -->
	<script src="js/angular/1.6.9/angular.min.js"></script>
	<script type="text/javascript" src="js/users.js"></script>

	<!-- angular-ui-bootstrap-2.2.0 -->
    <script src="js/angular/uibootstrap/2.5.0/uibootstrap.min.js"></script>
    

</body>

</html>