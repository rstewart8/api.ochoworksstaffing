<?php
error_reporting( E_ALL );
ini_set('display_errors', 1);

$logger         = new Logger(); 
$db             = new Database($logger); 

$data = json_decode(file_get_contents('php://input'), true);
$sysAdminStatus = explode(',',SYSADMINSTATUS);

if (isset($_POST) && count($_POST) > 0 && count($data) > 0) {
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
		$password = $data['password'];
		$confirm = ($data['confirm']);
		$status = strtolower($data['status']);

		if ($password != $confirm) {
			$res['status'] = 'fail';
			$res['msg'] = 'Passwords does not match.';
		} elseif (strlen($password) < PASSWORDMINLENGTH) {
			$res['status'] = 'fail';
			$res['msg'] = 'Password is less than '.PASSWORDMINLENGTH.' characters.';
		} elseif (strlen($password) > PASSWORDMAXLENGTH) {
			$res['status'] = 'fail';
			$res['msg'] = 'Password is greater than '.PASSWORDMAXLENGTH.' characters.';
		} elseif (!preg_match('/^(?=.*[\d])(?=.*[A-Z])(?=.*[a-z])(?=.*[!@#$%^&*])[\w!@#$%^&*]{8,}$/', $password)) {
			$res['status'] = 'fail';
			$res['msg'] = 'Invalid password.';
		} elseif (strlen($username) < USERMINLENGTH) {
			$res['status'] = 'fail';
			$res['msg'] = 'Username is less than '.USERMAXLENGTH.' characters.';
		} elseif (strlen($username) > USERMAXLENGTH) {
			$res['status'] = 'fail';
			$res['msg'] = 'Username is greater than '.USERMAXLENGTH.' characters.';
		} elseif (!preg_match('/^[$A-Z_][0-9A-Z_$]*$/i', $username)) {
			$res['status'] = 'fail';
			$res['msg'] = 'Invalid username.';
		} elseif (!in_array($status, $statuss)) {
			$res['status'] = 'fail';
			$res['msg'] = 'Invalid status.';
		} else {

			$qry = "SELECT id FROM system_users WHERE username = ?;";
			$values = [$username];
			$rows = $db->query($qry,$values);

			if (count($rows) > 0) {
				$res['status'] = 'fail';
				$res['msg'] = 'Username already exists.';
			} else {
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

$qry = "SELECT id,username,status FROM system_users WHERE status != 'deleted' ORDER BY username ASC;";
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
	ng-controller="adminCtrl">

	<?php require(ROOT.'/pages/includes/header.php'); ?>

	<div class="container">
		<div class="row">
            <div class="col-xs-12 ">
                <a href="./apiUsers"><h4>Users</h4></a>
            </div>
        </div>
        <div class="row">
            <div class="col-xs-12 ">
                <a href="./apiRoutes"><h4>Routes</h4></a>
            </div>
        </div>
        <div class="row">
            <div class="col-xs-12 ">
                <a href="./apiValidators"><h4>Validators</h4></a>
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
	<script type="text/javascript" src="js/admin.js"></script>

	<!-- angular-ui-bootstrap-2.2.0 -->
    <script src="js/angular/uibootstrap/2.5.0/uibootstrap.min.js"></script>
    

</body>

</html>