<?php

	session_start();

	header("Access-Control-Allow-Origin: *");
    header("Access-Control-Allow-Methods: PUT, GET, POST, DELETE, OPTIONS");
	header("Access-Control-Allow-Headers: Origin, X-Requested-With, Content-Type, Accept, Access");
	
	if ($_SERVER['REQUEST_METHOD'] == 'OPTIONS') {
		exit;
	}

	$path = realpath(__DIR__ . '/..');
	
	define('ROOT', $path);
	
	require_once(ROOT.'/configs/constants.php');
	require_once(ROOT . '/configs/globals.php');
	if (ENV != 'production') {
		error_reporting(E_ALL);
    	ini_set('display_errors', 1);
	}

	require_once(ROOT.'/core/initializers.php');
	require_once(ROOT.'/libs/logger.php');
	require_once(ROOT.'/core/routes.php');
	require_once(ROOT.'/core/responder.php');
	require_once(ROOT.'/core/database.php');

	$code			= 200;
	$status 		= 'error';
	$msg 			= null;
	$data 			= [];
	$logger 		= new Logger();	
	$db 			= new Database($logger);
	$routes 		= new Routes($db,$logger);
	$responder		= new Res($logger);
	$user			= null;

	try {
		$method = strtolower($_SERVER['REQUEST_METHOD']);


		$route = $routes->get($code,$method);

		if (!isset($route['status'])) {
			//route is a web page
			exit;
		}

		if ($route['status'] != 'ok') {
			$msg = ($route['msg'] != '') ? $route['msg'] : 'Invalid';
			throw new Exception($msg);
		}

		if (isset($route['user'])) {
			$user = $route['user'];
		}

		$req = $route['data'];

		$controller = $req['controller'];
		$function = $req['function'];

		if (!file_exists(ROOT.'/controllers/'.$controller.'Controller.php')){
			throw new Exception("Missing Controller");
		}

		require(ROOT.'/controllers/'.$controller.'Controller.php');

		$className = ucfirst($controller);
    	$c = new $className($db,$logger,$user);
    	if(!method_exists($c, $function)){
            throw new Exception('Invalid Function Class');
		}
		
		$res = $c->$function($req['params']);
		$code = (isset($res['code']) ? $res['code'] : 200);
        $status = $res['status'];
        $msg = $res['message'];
        $data = $res['data'];

	} catch (Exception $e) {
		if ($method === 'options') {
			$code = 200;
		}

		$logger->error('po44 - '.$e->getMessage());
		$status = 'error';

		$msg =  'Error po44 - '.$e->getMessage();
	}
	
	$responder->send($code,$status,$msg,$data);

?>