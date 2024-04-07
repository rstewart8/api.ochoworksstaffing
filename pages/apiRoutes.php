<?php
error_reporting(E_ALL);
ini_set('display_errors', 1);

require_once(ROOT . '/configs/constants.php');
require_once(ROOT . '/core/initializers.php');
require_once(ROOT . '/core/database.php');
require_once(ROOT . '/libs/logger.php');

$logger         = new Logger();
$db             = new Database($logger);

$data = json_decode(file_get_contents('php://input'), true);

function saveRoutes($db, $json, $logger)
{
	$res = [
		'status' => 'ok',
		'msg' => [],
		'data' => []
	];

	$qry = "SELECT * FROM roles ORDER BY id ASC;";
	$values = [];
	$rows = $db->query($qry, $values);
	$rolesMap = [];
	foreach ($rows as $row) {
		$rolesMap[$row['name']] = $row['id'];
	}

	$qry = "SELECT * FROM identitys ORDER BY id ASC;";
	$values = [];
	$rows = $db->query($qry, $values);
	$identitysMap = [];
	foreach ($rows as $row) {
		$identitysMap[$row['name']] = $row['id'];
	}

	$routes = [];
	$rolePermissions = [];
	$methodIdx = [
		'get' => 3,
		'post' => 4,
		'put' => 5,
		'delete' => 6
	];

	//// Remove all permissions to get reset below
	$qry = "DELETE FROM role_permissions WHERE id > 0";
	$db->query($qry, []);

	$qry = "DELETE FROM identity_permissions WHERE id > 0";
	$db->query($qry, []);

	//echo print_r($json,true);exit;
	foreach ($json as $j) {
		$controllerName = $j['name'];
		$routes[$controllerName] = [];
		foreach ($j['functions'] as $f) {
			$functionName = $f['name'];
			$routes[$controllerName][$functionName] = [];
			////Delete role permissions
			//$qry = "DELETE FROM role_permissions WHERE controller = ? AND `function` = ?;";
			//$values = [$controllerName, $functionName];
			//$db->query($qry, $values);

			$rolePermissionsCreated = false;

			////Delete identity permissions
			//$qry = "DELETE FROM identity_permissions WHERE controller = ? AND `function` = ?;";
			//$values = [$controllerName, $functionName];
			//$db->query($qry, $values);

			$identityPermissionsCreated = false;

			foreach ($f['methods'] as $m) {
				//// Create role_permissions and identity permisioned records if authenticate is true

				if ($m['authenticate'] == true && $rolePermissionsCreated == false) {
					foreach ($rolesMap as $roleId) {
						$qry = "INSERT INTO role_permissions (`role_id`,`controller`,`function`,`get`,`post`,`put`,`delete`) VALUES (?,?,?,0,0,0,0);";
						$values = [$roleId, $controllerName, $functionName];
						$db->insert($qry, $values);
					}
					$rolePermissionsCreated = true;
				}

				if ($m['authenticate'] == true && $identityPermissionsCreated == false) {
					foreach ($identitysMap as $identityId) {
						$qry = "INSERT INTO identity_permissions (`identity_id`,`controller`,`function`,`get`,`post`,`put`,`delete`) VALUES (?,?,?,0,0,0,0);";
						$values = [$identityId, $controllerName, $functionName];
						$db->insert($qry, $values);
					}
					$identityPermissionsCreated = true;
				}

				$methodName = $m['name'];
				$method = [
					'authenticate' => $m['authenticate'],
					'paramType' => $m['paramType'],
					'params' => []
				];
				foreach ($m['params'] as $p) {
					$paramName = $p['name'];
					$method['params'][$paramName] = [
						'type' => $p['type'],
						'required' => $p['required']
					];
				}
				$routes[$controllerName][$functionName][$methodName] = $method;

				if (isset($m['role_permissions'])) {
					foreach ($m['role_permissions'] as $role => $value) {
						if ($value) {
							$qry = "UPDATE role_permissions SET `$methodName` = 1 WHERE role_id = ? AND controller = ? AND `function` = ?;";
							$values = [$rolesMap[$role], $controllerName, $functionName];
							$db->update($qry, $values);
						}
					}
				}

				if (isset($m['identitys'])) {
					foreach ($m['identitys'] as $identity => $value) {
						if ($value) {
							$qry = "UPDATE identity_permissions SET `$methodName` = 1 WHERE identity_id = ? AND controller = ? AND `function` = ?;";
							$values = [$identitysMap[$identity], $controllerName, $functionName];
							$db->update($qry, $values);
						}
					}
				}
			}
		}
	}

	try {
		$db->commitTransaction();
		$path = ROOT . '/core/routes.json';
		file_put_contents($path, json_encode($routes));
		addDumps($logger);
	} catch (Exception $e) {
		$logger->error("error wrapping up: " . $e->getMessage());
	}
	header("HTTP/1.1 200 OK");
	header('Content-type: application/json');
	echo json_encode($res);
	exit;
}

function addDumps($logger)
{
	$path = ROOT . '/sqls/dumps/dumps.sql';
	if (file_exists($path)) {
		unlink($path);
	}
	try {
		exec('mysqldump --user=mradmin --password=password --host=localhost ochoworksstaffing role_permissions identity_permissions> /var/www/vhosts/ochoworksstaffing/sqls/dumps/dumps.sql');
	} catch (Exception $e) {
		$logger->error("error dumping: " . $e->getMessage());
	}
}
//echo print_r($data, true);
if (is_array($data) && count($data) > 0) {
	$res = [
		'status' => 'ok',
		'msg' => [],
		'data' => []
	];
	$res['data'] = $data['which'];
	if (
		$data['which'] == 'publishRoute'
		&& isset($data['json'])
	) {
		saveRoutes($db, $data['json'], $logger);
	} else {
		$res['status'] = 'fail';
		$res['msg'] = 'Missing data.';
	}

	header("HTTP/1.1 200 OK");
	header('Content-type: application/json');
	echo json_encode($res);
	exit;
}

$string = file_get_contents(ROOT . "/core/routes.json");
$routes = json_decode($string, true);
$data = [
	"routes" => [],
	"rolePermissions" => [],
	"identitys" => [],
	"requestMethodTypes" => ['get', 'post', 'put', 'delete']
];

$qry = "SELECT * FROM roles ORDER BY id ASC;";
$rows = $db->query($qry);

foreach ($rows as $row) {
	array_push($data['rolePermissions'], $row['name']);
}

$qry = "SELECT * FROM identitys ORDER BY id ASC;";
$rows = $db->query($qry);

foreach ($rows as $row) {
	array_push($data['identitys'], $row['name']);
}

$qry = "SELECT * FROM role_permissions AS rp JOIN roles AS r ON r.id = rp.role_id;";
$values = [];
$rows = $db->query($qry, $values);

foreach ($rows as $row) {
	$controller = $row['controller'];
	$function = $row['function'];
	//array_push($data['rolePermissions'],$row['name']);
	if (array_key_exists($controller, $routes)) {
		if (array_key_exists($function, $routes[$controller])) {
			if (array_key_exists('get', $routes[$controller][$function])) {
				$routes[$controller][$function]['get']['role_permissions'][$row['name']] = $row['get'] == 1 ? true : false;
			}
			if (array_key_exists('post', $routes[$controller][$function])) {
				$routes[$controller][$function]['post']['role_permissions'][$row['name']] = $row['post'] == 1 ? true : false;
			}
			if (array_key_exists('put', $routes[$controller][$function])) {
				$routes[$controller][$function]['put']['role_permissions'][$row['name']] = $row['put'] == 1 ? true : false;
			}
			if (array_key_exists('delete', $routes[$controller][$function])) {
				$routes[$controller][$function]['delete']['role_permissions'][$row['name']] = $row['delete'] == 1 ? true : false;
			}
		}
	}
}

$qry = "SELECT * FROM identity_permissions AS ip JOIN identitys AS i ON i.id = ip.identity_id;";
$values = [];
$rows = $db->query($qry, $values);

foreach ($rows as $row) {
	$controller = $row['controller'];
	$function = $row['function'];
	//array_push($data['rolePermissions'],$row['name']);
	if (array_key_exists($controller, $routes)) {
		if (array_key_exists($function, $routes[$controller])) {
			if (array_key_exists('get', $routes[$controller][$function])) {
				$routes[$controller][$function]['get']['identitys'][$row['name']] = $row['get'] == 1 ? true : false;
			}
			if (array_key_exists('post', $routes[$controller][$function])) {
				$routes[$controller][$function]['post']['identitys'][$row['name']] = $row['post'] == 1 ? true : false;
			}
			if (array_key_exists('put', $routes[$controller][$function])) {
				$routes[$controller][$function]['put']['identitys'][$row['name']] = $row['put'] == 1 ? true : false;
			}
			if (array_key_exists('delete', $routes[$controller][$function])) {
				$routes[$controller][$function]['delete']['identitys'][$row['name']] = $row['delete'] == 1 ? true : false;
			}
		}
	}
}

foreach ($routes as $k1 => $v1) { //Looping controllers
	$tmp = [];
	$tmp['name'] = $k1; //controller name
	$tmp['functions'] = [];
	foreach ($v1 as $k2 => $v2) { //Looping functions
		$availableMethods = array('get', 'post', 'put', 'delete');
		$tmp2 = [];
		$tmp2['name'] = $k2; //function name
		$tmp2['methods'] = [];
		foreach ($v2 as $k3 => $v3) {	//Looping methods
			if (($ind = array_search($k3, $availableMethods)) !== false) {
				unset($availableMethods[$ind]);
			}
			$tmp3 = [];
			$tmp3['name'] = $k3; //method name 

			$tmp3['permissions'] = false;
			if (isset($v3['identitys'])) {
				$tmp3['permissions'] = true;
			}

			foreach ($v3 as $k4 => $v4) { //Looping method params
				if ($k4 == 'params' && count($v4) > 0) {
					$tmp3[$k4] = [];
					$tmp4 = [];

					foreach ($v4 as $k5 => $v5) {
						$tmp4['name'] = $k5; //param name
						foreach ($v5 as $k6 => $v6) {
							$tmp4[$k6] = $v6;
						}
						array_push($tmp3[$k4], $tmp4);
					}
				} else {
					$tmp3[$k4] = $v4;
				}
			}

			$methods = [];

			foreach ($availableMethods as $method) {
				array_push($methods, $method);
			}

			$tmp2['availableMethods'] = $methods;
			array_push($tmp2['methods'], $tmp3);
		}
		array_push($tmp['functions'], $tmp2);
	}
	array_push($data['routes'], $tmp);
}
//echo "routes json: <pre>".print_r($routes,true)."</pre>";
?>
<!DOCTYPE html>
<html lang="en">

<head>

	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<meta name="description" content="">
	<meta name="author" content="">

	<title>PDQ-Api - Endpoints</title>

	<!-- Bootstrap Core CSS -->
	<link href="css/bootstrap.min.css" rel="stylesheet">
	<link href="css/main.css" rel="stylesheet">

	<script type="text/javascript">
		window.data = <?php echo json_encode($data); ?>;
	</script>

	<!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
	<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
	<!--[if lt IE 9]>
		<script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
		<script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
	<![endif]-->

</head>

<body ng-app="app" ng-controller="routeCtrl" ng-init="init('data')">

	<!-- ***** modal templates ***** -->

	<script type="text/ng-template" id="publishRoute.html">
		<div class="modal-header">
			<h3 class="modal-title" id="modal-title">Publish Route Changes?</h3>
		</div>
		<div class="modal-body" id="modal-body">
			<h4>Are you sure you want to publish changed routes?</h4>
			<h4>Publishing will overwrite existing core/routes.json file and rewrite role_permissions table</h4>
			<div class="row">
				<div class="col-xs-12 col-sm-4 text-right">
					<strong>To allow type 'yes'</strong>
				</div>
				<div class="col-xs-12 col-sm-4 text-left">
					<div class="form-group">
						<input
							type="text"
							class="form-controller"
							ng-model="yes">
					</div>
				</div>
			</div>
		</div>
		<div class="modal-footer">
			<button ng-show="isYes()" class="btn btn-primary" type="button" ng-click="publishRoutes()">Publish</button>
			<button class="btn btn-warning" type="button" ng-click="cancel()">Cancel</button>
		</div>
	</script>

	<script type="text/ng-template" id="addController.html">
		<div class="modal-header">
			<h3 class="modal-title" id="modal-title">Create New Route</h3>
		</div>
		<div class="modal-body" id="modal-body">
			<label>
				Route Name
				<input
					type="text"
					class="form-controller"
					ng-model="addControllerName"
					ng-model-options="{ debounce: 200 }"
					ng-change="addControllerNameChange()">
			</label>

			<span ng-show="addControllerNameValid">
				<div class="row">
					<div class="col-xs-12">
						<strong>Create this file:</strong>
					</div>
				</div>
				<div class="row">
					<div 
						class="col-xs-12 color-blue">
						<strong> /PathToRepo/controllers/{{addControllerName}}Controller.php</strong>
					</div>
				</div>
				<br>
				<div class="row">
					<div class="col-xs-12">
						<strong>Add this class to <i>{{addControllerName}}Controller.php</i>:</strong>
					</div>
				</div>
				<div class="row">
					<div 
						class="col-xs-12 color-blue">
						<strong>class {{addControllerName | capitalize}} {   //Add functions here   }</strong>
					</div>
				</div>
			</span>
		</div>
		<div class="modal-footer">
			<button ng-show="addControllerNameValid" class="btn btn-primary" type="button" ng-click="addNewController()">Add</button>
			<button class="btn btn-warning" type="button" ng-click="cancel()">Cancel</button>
		</div>
	</script>

	<script type="text/ng-template" id="addFunction.html">
		<div class="modal-header">
			<h3 class="modal-title" id="modal-title">Create New Function</h3>
		</div>
		<div class="modal-body" id="modal-body">
			<label>
				Function Name
				<input
					type="text"
					class="form-controller"
					ng-model="addFunctionName"
					ng-model-options="{ debounce: 200 }"
					ng-change="addFunctionNameChange()">
			</label>
			<span ng-show="addFunctionNameValid">
				<div class="row">
					<div class="col-xs-12">
						<strong>Add function:</strong>
					</div>
				</div>
				<div class="row">
					<div class="col-xs-12 color-blue">
						<strong>function {{addFunctionName}}($data=null){ return array('status' => 'ok','message' => 'In development','data' => '' ); }</strong>
					</div>
				</div>
				<div class="row">
					<div class="col-xs-12">
						<strong>to class <i>{{controller | capitalize}}</i></strong>
					</div>
				</div>
				<div class="row">
					<div class="col-xs-12">
						<strong>in this file</strong>
					</div>
				</div>
				<div class="row">
					<div 
						class="col-xs-12">
						<strong> /PathToRepo/controllers/{{controller}}Controller.php</strong>
					</div>
				</div>
			</span>
		</div>
		<div class="modal-footer">
			<button ng-show="addFunctionNameValid" class="btn btn-primary" type="button" ng-click="addNewFunction()">Add</button>
			<button class="btn btn-warning" type="button" ng-click="cancel()">Cancel</button>
		</div>
	</script>

	<script type="text/ng-template" id="addMethod.html">
		<div class="modal-header">
			<h3 class="modal-title" id="modal-title">Create New Method</h3>
		</div>
		<div class="modal-body" id="modal-body">
			<div class="row">
				<div class="col-xs-12 col-sm-4">
					<strong>Request Method</strong>
				</div>
				<div class="col-xs-12 col-sm-4">
					<span ng-show="availableMethods.length > 0">
						<select
							class="form-control" 
							ng-model="addMethodName">
							<option ng-repeat="m in availableMethods">{{m}}</option>
						</select>
					</span>
					<span ng-show="availableMethods.length < 1">All methods have been assigned to this function</span>
				</div>
			</div>
		</div>
		<div class="modal-footer">
			<button ng-show="addMethodName !== undefined" class="btn btn-primary" type="button" ng-click="addNewMethod()">Add</button>
			<button class="btn btn-warning" type="button" ng-click="cancel()">Cancel</button>
		</div>
	</script>

	<!-- ***** modal templates end ***** -->

	<?php require(ROOT . '/pages/includes/header.php'); ?>

	<div class="container">
		<div class="row">
			<div class="col-xs-12 col-sm-2 text-left">
				<button ng-click="open('addController')" type="button" class="btn btn-primary btn-sm">
					Add Route
				</button>
			</div>
			<div class="col-xs-12 col-sm-3">
				<select class="form-control" ng-options="cont as cont for cont in controllers" ng-model="selectedAnchor" ng-change="goToAnchor()">
				</select>
			</div>
			<div class="col-xs-12 col-sm-offset-5 col-sm-1 text-right">
				<button ng-click="open('publishRoute')" type="button" class="btn btn-primary btn-md" ng-disabled="!validRoutes">
					Publish
				</button>
			</div>
			<div class="col-xs-12 col-sm-1 text-right">
				<button ng-click="resetPage()" type="button" class="btn btn-warning btn-md">Reset</button>
			</div>
		</div>
		<span ng-repeat="route in routes">
			<div id="anchor{{route.name}}" class="row header-controller">
				<div class="col-xs-4 col-sm-3">
					<input class="form-control" ng-class="{'error': route.errors.hasErrors === true}" type="text" style="margin-top:2px;margin-bottom:2px;" ng-model-options="{ debounce: 200 }" ng-change="validateRoute()" ng-model="route.name">
				</div>
				<div class="col-xs-4 col-sm-2 text-right">
					<button ng-click="open('addFunction',route.name)" type="button" class="btn btn-success btn-xs" style="margin-top:8px;">
						Add Function
					</button>
				</div>
				<div class="col-xs-2 col-sm-1">
					<button ng-click="deleteRoute(route.index)" type="button" class="btn btn-danger btn-xs" style="margin-top:8px;">
						Delete
					</button>
				</div>
				<div ng-init="showController[$index] = false" class="col-xs-2 col-sm-6 text-right">
					<div class="cursor-pointer text-right" ng-click="showController[$index] = !showController[$index]" ng-show="!showController[$index]">open
					</div>
					<div class="cursor-pointer text-right" ng-click="showController[$index] = !showController[$index]" ng-show="showController[$index]">close
					</div>
				</div>
			</div>
			<div class="row" ng-if="route.errors.hasErrors === true">
				<div class="col-xs-12 col-sm-4 errors-container">
					<ul>
						<li class="error" ng-if="route.errors.unique === true">
							Route Name needs to be unique
						</li>
						<li class="error" ng-if="route.errors.minLength === true">
							Route Name cannot be less then 3 characters
						</li>
						<li class="error" ng-if="route.errors.valid === true">
							Route Name is not valid
						</li>
					</ul>
				</div>
			</div>
			<span ng-repeat="function in route.functions" ng-show="showController[$parent.$index]">
				<div class="row header-function">
					<div class="col-xs-4 col-sm-3">
						<input class="form-control" ng-class="{'error': function.errors.hasErrors === true}" type="text" style="margin-top:2px;margin-bottom:2px;" ng-model-options="{ debounce: 200 }" ng-change="validateRoute()" ng-model="function.name">
					</div>
					<div class="col-xs-4 col-sm-3 text-right">
						<button ng-click="open('addMethod',route.index,function.index)" type="button" class="btn btn-success btn-xs" style="margin-top:8px;">
							Add Method
						</button>
					</div>
					<div class="col-xs-2 col-sm-3">
						<button ng-click="deleteFunction(route.index,function.index)" type="button" class="btn btn-danger btn-xs" style="margin-top:8px;">
							Delete
						</button>
					</div>
					<div ng-init="showFunction[$index] = false" class="col-xs-1 col-sm-3 text-right">
						<div class="cursor-pointer text-right" ng-click="showFunction[$index] = !showFunction[$index]" ng-show="!showFunction[$index]">open
						</div>
						<div class="cursor-pointer text-right" ng-click="showFunction[$index] = !showFunction[$index]" ng-show="showFunction[$index]">close
						</div>
					</div>
				</div>
				<div class="row" ng-if="function.errors.hasErrors === true">
					<div class="col-xs-12 col-sm-4 errors-container">
						<ul>
							<li class="error" ng-show="function.errors.unique === true">
								Function Name needs to be unique
							</li>
							<li class="error" ng-show="function.errors.minLength === true">
								Function Name cannot be less then 3 characters
							</li>
							<li class="error" ng-show="function.errors.valid === true">
								Function Name is not valid
							</li>
						</ul>
					</div>
				</div>
				<span ng-repeat="method in function.methods" ng-show="showFunction[$parent.$index]">
					<div class="row header-method">
						<div class="col-xs-5 col-sm-2">
							<select class="form-control" ng-class="{'error': method.errors.hasErrors === true}" style="margin-top:2px;margin-bottom:2px;" ng-model="method.name" ng-change="resetAvailableMethods(route.index,function.index)">
								<option>{{method.name}}</option>
								<option ng-repeat="m in function.availableMethods">{{m}}</option>
							</select>
						</div>
						<div class="col-xs-2 col-sm-3">
							<button ng-click="deleteMethod(route.index,function.index,method.index)" type="button" class="btn btn-danger btn-xs" style="margin-top:8px;">
								Delete
							</button>
						</div>
					</div>
					<div class="row" style="margin-left:25px;">
						<div class="col-xs-3 col-sm-3">
							<div class="checkbox">
								<label>
									<input type="checkbox" ng-model="method.authenticate">
									authenticate
								</label>
							</div>
						</div>
					</div>
					<div class="row" style="margin-left:25px;">
						<div class="col-xs-12">
							<div class="checkbox">
								<label>
									<input type="checkbox" ng-model="method.permissions" ng-change="rolePermissionsChange(method)">
									permissions
								</label>
							</div>
						</div>
					</div>
					<div class="row" style="margin-left:25px;">
						<div class="col-xs-12 col-sm-3" ng-repeat="(role,value) in method.role_permissions">
							<div class="checkbox">
								<label>
									<input type="checkbox" ng-model="method.role_permissions[role]">
									{{role}}
								</label>
							</div>
						</div>
					</div>
					<div style="margin-left:40px;"  ng-show="showIdentitys === true || method.permissions"><strong>Identities</strong></div>
					<div class="row" style="margin-left:25px;">
						<div class="col-xs-12 col-sm-3" ng-repeat="(identity,value) in method.identitys">
							<div class="checkbox">
								<label>
									<input type="checkbox" ng-model="method.identitys[identity]">
									{{identity}}
								</label>
							</div>
						</div>
					</div>
					<div class="row" style="margin-left:25px;">
						<div class="col-xs-6 col-sm-2">
							<strong>Params</strong>
						</div>
						<div class="col-xs-6 col-sm-2">
							<button ng-click="addNewParam(route.name,function.name,method.name)" type="button" class="btn btn-success btn-xs">
								Add New Param
							</button>
						</div>
					</div>

					<div class="row" style="margin-left:25px">
						<div class="col-xs-6 col-sm-2">
							<select class="form-control" style="margin-top:2px;margin-bottom:2px;" ng-model="method.paramType" ng-change="validateRoute()">
								<option ng-repeat="type in paramTypes">{{type}}</option>
							</select>
						</div>
					</div>

					<div class="row" style="margin-left:25px;margin-top: 5px;">
						<div class="col-xs-12 col-sm-10">
							<table class="table table-condensed table-responsive">
								<thead>
									<tr>
										<th>Name</th>
										<th>Type</th>
										<th>Required</th>
										<th></th>
										<th></th>
									</tr>
								</thead>
								<tbody>
									<tr ng-repeat="param in method.params">
										<td>
											<input class="form-control" type="text" ng-model-options="{ debounce: 200 }" ng-change="validateRoute()" ng-model="param.name">
										</td>
										<td>
											<select class="form-control" ng-model="param.type" ng-change="validateRoute()">
												<option value="array">array</option>
												<option value="json">json</option>
												<option value="value">value</option>
												<option value="binary">binary</option>
											</select>
										</td>
										<td>
											<div class="checkbox">
												<label>
													<input type="checkbox" ng-model="param.required">
												</label>
											</div>
										</td>
										<td>
											<ul>
												<li class="error" ng-show="param.errors.uniqueName === true">Name must be unique
												</li>
												<li class="error" ng-show="param.errors.invalidName === true">Name must be valid
												</li>
												<li class="error" ng-show="param.errors.invalidType === true">Type must be valid
												</li>
											</ul>
										</td>
										<td>
											<button ng-click="deleteParam(route.index,function.index,method.index,param.index)" type="button" class="btn btn-danger btn-xs" style="margin-top:8px;">
												Delete
											</button>
										</td>
									</tr>
								</tbody>
							</table>
						</div>
					</div>
				</span>
			</span>
		</span>

		<br>
	</div>
	<pre>{{routes | json}}</pre>
	<!-- jQuery Version 1.11.1 -->
	<script src="js/jquery.js"></script>
	<!-- <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.4.2/jquery.min.js"></script> -->

	<!-- Bootstrap Core JavaScript -->
	<script src="js/bootstrap.min.js"></script>

	<!-- angular Version 1.6.9 -->
	<script src="js/angular/1.6.9/angular.min.js"></script>
	<script type="text/javascript" src="js/routes.js"></script>

	<!-- angular-ui-bootstrap-2.2.0 -->
	<script src="js/angular/uibootstrap/2.5.0/uibootstrap.min.js"></script>


</body>

</html>