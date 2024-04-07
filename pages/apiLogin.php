<?php 

$loginError = '';

if (!empty( $_POST)) {
    if (isset( $_POST['username'] ) && isset( $_POST['password'])) {
        // Getting submitted user data from database
        $conn = mysqli_connect(DBHOST, DBUSER, DBPASS, DBNAME);
		mysqli_set_charset($conn,'utf8');
		if (mysqli_connect_errno()) {
			echo "ERROR: MYSQLI Connection: ".mysqli_connect_error();
		}
        if ($stmt = $conn->prepare("SELECT * FROM system_users WHERE username = ? AND password = ? AND status = 'active';")){
        	$password = md5($_POST['password']);
	        $stmt->bind_param('ss', $_POST['username'],$password);
	        $stmt->execute();
	        $result = $stmt->get_result();

	        if ($result->num_rows < 1) {
	        	$loginError = "Invalid username or password";
	        } else {
	        	$user = $result->fetch_object();
	        	$_SESSION['user_id'] = $user->id;
	        	$_SESSION['user_name'] = $user->username;
	        	header('Location: /apiAdmin');
			    exit;
	        }
	    }
    }
}
?>

<!DOCTYPE html>
<html lang="en">

<head>

	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<meta name="description" content="">
	<meta name="author" content="">

	<title>API - Login</title>

	<!-- Bootstrap Core CSS -->
	<link href="css/bootstrap.min.css" rel="stylesheet">
	<link href="css/main.css" rel="stylesheet">

	<style>
	body {
		padding-top: 70px;
		/* Required padding for .navbar-fixed-top. Remove if using .navbar-static-top. Change if height of navigation changes. */
	}

	.loginForm {
		width:80%;
		margin:auto;
		max-width:300px;
		background-color: #C7C7C7;
		border-radius: 10px;
		padding: 20px;
	}
	</style>

	<!-- Custom CSS -->

	<!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
	<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
	<!--[if lt IE 9]>
		<script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
		<script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
	<![endif]-->

</head>

<body>
	<div class="loginForm">
		<h3>Admin Login</h3>
		<form action="" method="post">
			<div class="form-group">
				<label for="username">User Name:</label>
				<input type="text" class="form-control" id="username" name="username" required>
			</div>
			<div class="form-group">
				<label for="password">Password:</label>
				<input type="password" class="form-control" id="password" name="password" required>
			</div>
			<h5 class="error"><?php echo $loginError; ?></h5>
			<button type="submit" class="btn btn-success">Submit</button>
		</form>
	</div>

	<!-- jQuery Version 1.11.1 -->
	<script src="js/jquery.js"></script>
	<!-- <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.4.2/jquery.min.js"></script> -->
	<script type="text/javascript" src="js/main.js"></script>

	<!-- Bootstrap Core JavaScript -->
	<script src="js/bootstrap.min.js"></script>

</body>

</html>