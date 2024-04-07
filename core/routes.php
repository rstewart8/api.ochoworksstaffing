<?php
/**
*
*/

require_once(ROOT.'/core/validator.php');
require_once(ROOT.'/core/authentication.php');

class Routes
{


	function __construct($db,$logger) {
		$this->res = [
			'status' 	=> 'ok',
			'msg'		=> '',
			'data'		=> []
		];
		$this->logger = $logger;
		$this->authentication = new Authentication($db,$logger);
	}

	public function get(&$code,$method) {
		
		$request = explode('/',ltrim($_SERVER['REQUEST_URI'],'/'));

		if (ENV !== 'production') {

			if ($request[0] == '') {
				require(ROOT."/pages/apiHome.php");
				return ;
			}
			
			if ($request[0] == 'apiLogin') {
				require(ROOT."/pages/apiLogin.php");
				return ;
			}
			$authPages = [
				'apiAdmin',
				'apiRoutes',
				'apiUsers',
				'apiValidators'
			];
			
			if (in_array($request[0],$authPages)) {
				$page = "/pages/$request[0].php";

				if (!isset($_SESSION['user_id'])) {
					header('Location: /apiLogin');
				    exit;
				}

				require(ROOT.$page);
				return ;
			}
		}
		
		if (count($request) < 2) {
			$this->error("Missing function");
			$this->res['status'] = 'error';
			return $this->res;
		}
		$controller = $request[0];
		$func = $request[1];
		$func = explode('?', $func);
		$function = $func[0];
		// $method = strtolower($_SERVER['REQUEST_METHOD']);

		//Load routes json
		$json = file_get_contents(ROOT."/core/routes.json");
		$r = json_decode($json, true);

		//Check that controller exists in routes.json
		if (!array_key_exists($controller,$r)) {
			$this->error("Invalid Controller");
			$this->res['status'] = 'error';
			return $this->res;
		}

		//Check in function exists in routes.json
		if (!array_key_exists($function,$r[$controller])) {
			$this->error("Invalid Function");
			$this->res['status'] = 'error';
			return $this->res;
		}

		//Check in method exists in routes.json
		if (!array_key_exists($method,$r[$controller][$function])) {
			$this->error("Invalid Method: $method");
			$this->res['status'] = 'error';
			return $this->res;
		}

		$user = null;

		if ($r[$controller][$function][$method]['authenticate'] == true) {
			$authenticate = $this->authentication->authenticate($controller,$function);
			$user = $authenticate['user'];
			
			if ($authenticate['status'] != 'ok') {
				$code = 401;
				throw new Exception($authenticate['msg']);
			}
		}
		
		//Get sent params
		$input = [];
		if ($method == 'get') {
			$input = $_GET;
		} else {
			if ($r[$controller][$function][$method]['paramType'] == 'json') {
				$input = json_decode(file_get_contents('php://input'),true);
			} elseif ($r[$controller][$function][$method]['paramType'] == 'form') {
				$input = $_POST;
				if (!isset($_FILES) || count($_FILES) < 1) {
					$this->error("File Missing");
					$this->res['status'] = 'error';
					return $this->res;
				}
				if (isset($_FILES)) {
					$input['files'] = $_FILES['files'];
				}
			}
		}

		

		$params = $r[$controller][$function][$method]['params'];
		$missingRequired = [];
		$validateErrors = [];
		$check = $input;

		//// If get method remove global params from check
		if ($method == 'get') {
			$globalGetParams = unserialize(GLOBALGETPARAMS);
			foreach($globalGetParams as $p) {
				if (array_key_exists($p,$check)) {
					unset($check[$p]);
				}
			}
		} 
		
		$validator = new Validator($this->logger,$controller,$function,$method);

		$flatParams = [];

		foreach ($params as $k => $v) {
			if ($v['required'] == 1) {
				if (!array_key_exists($k,$check)){
					$missingRequired[] = $k;
					break;
				} 
			}

			$broke = false;
			if ($v['type'] == 'json') {
				$validate = $validator->validate($input[$k],$k);
				if($validate['status'] != 'ok') {
					$validateErrors = $validate['data'];
					break;
				}
			} else if ($v['type'] == 'array') {
				if (count($input[$k]) < 1) {
					$validateErrors = ['Missing array values'];
					$broke = true;
					break;
				}
				foreach ($input[$k] as $v2) {
					$validate = $validator->validate($v2,$k);
					if($validate['status'] != 'ok') {
						$validateErrors = $validate['data'];
						$broke = true;
						break;
					}
				}
			} else if ($v['type'] == 'binary') {
				//// Maybe do something here for binary files
			
			} else {
				if (array_key_exists($k, $input)) {
					$flatParams[$k] = $input[$k];
				}				
			}

			if ($broke == true) {
				break;
			}

			if (array_key_exists($k,$check)) {
				unset($check[$k]);
			}
		}

		if (count($flatParams) > 0) {
			$k = $controller.ucfirst($function).ucfirst($method);
			$validate = $validator->validate($flatParams,$k);
			if($validate['status'] != 'ok') {
				$validateErrors = $validate['data'];
			}
		}
		
		if (count($validateErrors) > 0) {
			$msg = implode(',', $validateErrors);
			$this->error($msg);
			$this->res['status'] = 'error';
			$this->res['msg'] = $msg;
			return $this->res;
		}

		if (count($missingRequired) > 0) {
			$msg = "Missing Required Params: ".implode(',', $missingRequired);
			$this->error($msg);
			$this->res['status'] = 'error';
			$this->res['msg'] = $msg;
			return $this->res;
		}
		
		if (count($check) > 0) {
			$keys = implode(',',array_keys($check));
			$msg = "Invalid Params: $keys";
			$this->error($msg);
			$this->res['status'] = 'error';
			$this->res['msg'] = $msg;
			return $this->res;
		}

		// $validate = $this->validator->validate($controller,$function,$method,$input);
		// if ($validate['status'] != 'ok') {
		// 	$msg = "Invalid Params: $validate[msg]";
		// 	$this->error($msg);
		// 	$this->res['status'] = 'error';
		// 	$this->res['msg'] = $msg;
		// 	return $this->res;
		// }


		$data = [
			'method'		=> $method,
			'controller'	=> $controller,
			'function' 		=> $function,
			'params' 		=> $input
		];

		$this->res['user'] = $user;
		$this->res['data'] = $data;
		return $this->res;
	}

	public function error($msg){
		$this->res['status'] = 'error';
		$this->res['msg'] = $msg;
		$this->logger->error($msg);
	}
}

?>