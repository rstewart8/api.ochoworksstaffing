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

function deleteValidator($fileName)
{
	$res = [
		'status' => 'ok',
		'msg' => [],
		'data' => []
	];

	$path = ROOT . "/core/validators/$fileName.json";
	unlink($path);
	header("HTTP/1.1 200 OK");
	header('Content-type: application/json');
	echo json_encode($res);
	exit;
}

function saveValidator($json, $fileName)
{
	$res = [
		'status' => 'ok',
		'msg' => [],
		'data' => []
	];

	//echo print_r($json,true);

	$params = [];

	foreach ($json['params'] as $j) {
		$params[$j['name']] = [
			'type' => $j['params']['type'],
			'allowNull' => $j['params']['allowNull'],
			'properties' => [],
			'required' => [],
			'exclude' => [],
			'novalidate' => []
		];

		foreach ($j['params']['properties'] as $v) {
			$params[$j['name']]['properties'][$v['name']] = $v['value'];
		}

		if (isset($j['params']['required'])) {
			foreach ($j['params']['required'] as $v) {
				$params[$j['name']]['required'][] = "$v[controller]|$v[function]|$v[method]";
			}
		}

		if (isset($j['params']['exclude'])) {
			foreach ($j['params']['exclude'] as $v) {
				$params[$j['name']]['exclude'][] = "$v[controller]|$v[function]|$v[method]";
			}
		}

		if (isset($j['params']['novalidate'])) {
			foreach ($j['params']['novalidate'] as $v) {
				$params[$j['name']]['novalidate'][] = "$v[controller]|$v[function]|$v[method]";
			}
		}
	}

	$validator = [
		'params' => $params
	];

	$path = ROOT . "/core/validators/$fileName";
	file_put_contents($path, json_encode($validator));

	header("HTTP/1.1 200 OK");
	header('Content-type: application/json');
	echo json_encode($res);
	exit;
}

function getValidator($fileName)
{
	$data = [
		'params' => []
	];
	$path = ROOT . "/core/validators/$fileName.json";

	$string = file_get_contents($path);
	$validator = json_decode($string, true);

	foreach ($validator['params'] as $key => $value) {
		//echo "key: $key value: ".print_r($value,true);
		$p = [
			'name' => $key,
			'params' => $value
		];

		$properties = [];
		$required = [];
		$exclude = [];
		$novalidate = [];

		foreach ($value['properties'] as $k => $v) {
			array_push($properties, ['name' => $k, 'value' => $v]);
		}

		if (isset($value['required'])) {
			foreach ($value['required'] as $v) {
				$r = explode('|', $v);
				array_push($required, ['controller' => $r[0], 'function' => $r[1], 'method' => $r[2]]);
			}
		}

		if (isset($value['exclude'])) {
			foreach ($value['exclude'] as $v) {
				$r = explode('|', $v);
				array_push($exclude, ['controller' => $r[0], 'function' => $r[1], 'method' => $r[2]]);
			}
		}

		if (isset($value['novalidate'])) {
			foreach ($value['novalidate'] as $v) {
				$r = explode('|', $v);
				array_push($novalidate, ['controller' => $r[0], 'function' => $r[1], 'method' => $r[2]]);
			}
		}

		$p['params']['properties'] = $properties;
		$p['params']['required'] = $required;
		$p['params']['exclude'] = $exclude;
		$p['params']['novalidate'] = $novalidate;

		array_push($data['params'], $p);
	}

	return $data;
}

if ($data && count($data) > 0) {
	$res = [
		'status' => 'ok',
		'msg' => [],
		'data' => []
	];

	if (
		$data['which'] == 'getValidator'
		&& isset($data['fileName'])
	) {
		$res['data'] = getValidator($data['fileName']);
	} elseif (
		$data['which'] == 'publishValidator'
		&& isset($data['json'])
		&& isset($data['fileName'])
		&& $data['fileName'] != ''
	) {
		saveValidator($data['json'], $data['fileName']);
	} elseif (
		$data['which'] == 'deleteValidator'
		&& isset($data['fileName'])
		&& $data['fileName'] != ''
	) {
		deleteValidator($data['fileName']);
	} else {
		$res['status'] = 'fail';
		$res['msg'] = 'Missing data.';
	}

	header("HTTP/1.1 200 OK");
	header('Content-type: application/json');
	echo json_encode($res);
	exit;
}

$files = glob(ROOT . "/core/validators/*.json");
$fileNames = [];

foreach ($files as $file) {
	$fileName = basename($file, ".json");
	array_push($fileNames, $fileName);
}

$data['fileNames'] = $fileNames;

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
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

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

<body ng-app="app" ng-controller="validatorCtrl" ng-init="init('data')">

	<!-- ***** modal templates ***** -->


	<!-- ***** modal templates end ***** -->

	<?php require(ROOT . '/pages/includes/header.php'); ?>

	<div class="container">
		<div class="row">
			<div class="col-xs-12 col-sm-2">
				<h4>New Validators:</h4>
			</div>
			<div class="col-xs-12 col-sm-3">
				<input class="form-control" ng-class="{'error': newValidator.errors.hasErrors === true}" type="text" style="margin-top:2px;margin-bottom:2px;" ng-model-options="{ debounce: 200 }" ng-change="validateNewValidator()" ng-model="newValidator.name">
			</div>
			<div class="col-xs-12 col-sm-2">
				<button ng-click="addNewValidator()" ng-disabled="newValidator.errors.hasErrors === true || newValidator.name === null || newValidator.name === ''" type="button" class="btn btn-success btn-xs" style="margin-top:8px;">
					Add New Validator
				</button>
			</div>
		</div>
		<div class="row">
			<div class="col-xs-12 col-sm-5 col-sm-offset-2 errors-container">
				<ul>
					<li class="error" ng-if="newValidator.errors.unique === true">
						Validator must be unique
					</li>
					<li class="error" ng-if="newValidator.errors.minLength === true">
						Validator cannot be less then 2 characters
					</li>
					<li class="error" ng-if="newValidator.errors.valid === true">
						Validator is not valid
					</li>
				</ul>
			</div>
		</div>
		<hr>
		<div ng-init="show=true" ng-hide="!show" class="row">
			<div ng-repeat="file in fileNames" class="col-xs-6 col-sm-3">
				<a style="display:inline-block;" ng-click="getFile(file)">
					<h4>{{file}}</h4>
				</a>
				<a style="display:inline-block;" ng-click="deleteFile(file)"><i style="margin-left:10px;" class="fa fa-trash error"></i></a>
			</div>
		</div>
		<div class="row">
			<div class="col-xs-12 text-center">
				<a ng-click="show = !show">
					<span ng-show="!show">show</span>
					<span ng-show="show">hide</span>
				</a>
			</div>
		</div>
		<hr>
		<span ng-show="fileName != ''">
			<div class="row">
				<div class="col-xs-12 col-sm-6">
					<h3 style="margin-top:5px;">{{fileName}}</h3>
				</div>
				<div class="col-xs-12 col-sm-2 col-sm-offset-2 text-right">
					<button ng-click="publishValidator()" type="button" class="btn btn-primary btn-md" ng-disabled="!isValidValidator">
						Publish
					</button>
				</div>
				<div class="col-xs-12 col-sm-2 text-right">
					<button ng-click="resetPage()" type="button" class="btn btn-warning btn-md">Reset</button>
				</div>
			</div>
			<div class="row">
				<div class="col-xs-12 col-sm-3">
					<h4>New Param:</h4>
				</div>
				<div class="col-xs-12 col-sm-4">
					<input class="form-control" ng-class="{'error': newParam.errors.hasErrors === true}" type="text" style="margin-top:2px;margin-bottom:2px;" ng-model-options="{ debounce: 200 }" ng-change="validateNewParam()" ng-model="newParam.name">
				</div>
				<div class="col-xs-12 col-sm-3">
					<button ng-click="addNewParam()" ng-disabled="newParam.errors.hasErrors === true || newParam.name === null || newParam.name === ''" type="button" class="btn btn-success btn-xs" style="margin-top:8px;">
						Add New Param
					</button>
				</div>
			</div>
			<div class="row">
				<div ng-if="newParam.errors.hasErrors === true" class="row">
					<div class="col-xs-12 col-sm-7 col-sm-offset-3 errors-container">
						<ul>
							<li class="error" ng-if="newParam.errors.unique === true">
								Param must be unique
							</li>
							<li class="error" ng-if="newParam.errors.minLength === true">
								Param cannot be less then 2 characters
							</li>
							<li class="error" ng-if="newParam.errors.valid === true">
								Param is not valid
							</li>
						</ul>
					</div>
				</div>
			</div>
		</span>
		<span ng-repeat="param in validator.params">
			<div class="row header-controller">
				<div class="col-xs-4 col-sm-3">
					<input class="form-control" ng-class="{'error': param.errors.hasErrors === true}" type="text" style="margin-top:2px;margin-bottom:2px;" ng-model-options="{ debounce: 200 }" ng-change="validateParams()" ng-model="param.name">
				</div>
				<div class="col-xs-2 col-sm-1">
					<button ng-click="deleteParam($index)" type="button" class="btn btn-danger btn-xs" style="margin-top:8px;">
						Delete
					</button>
				</div>
				<div ng-init="showParam[$index] = false" class="col-xs-6 col-sm-8 text-right">
					<div class="cursor-pointer text-right" ng-click="showParam[$index] = !showParam[$index]" ng-show="!showParam[$index]">open
					</div>
					<div class="cursor-pointer text-right" ng-click="showParam[$index] = !showParam[$index]" ng-show="showParam[$index]">close
					</div>
				</div>
			</div>
			<div class="row" ng-if="param.errors.hasErrors === true">
				<div class="col-xs-12 col-sm-4 errors-container">
					<ul>
						<li class="error" ng-if="param.errors.unique === true">
							Param needs to be unique
						</li>
						<li class="error" ng-if="param.errors.minLength === true">
							Param cannot be less then 2 characters
						</li>
						<li class="error" ng-if="param.errors.valid === true">
							Param is not valid
						</li>
					</ul>
				</div>
			</div>
			<span ng-repeat="(key,value) in param.params" ng-show="showParam[$parent.$index]">
				<div ng-if="key === 'type'" class="row" style="margin-left:25px;padding-top:5px;">
					<span>Types: integer,string,password,email,codestr,namestr,array,mysqlDate,mysqlDateTime</span>
				</div>
				<div ng-if="key === 'type'" class="row" style="margin-left:25px;padding-top:5px;">
					<div class="col-xs-12 col-sm-2">
						<strong>Type</strong>
					</div>
					<div class="col-xs-12 col-sm-2">
						<input type="text" class="form-control input-sm" ng-class="{'error': param.errors.type.hasErrors === true}" ng-model="param.params[key]" ng-model-options="{ debounce: 200 }" ng-change="validateParams()">
					</div>
					<div class="col-xs-12 col-sm-4 errors-container" ng-if="param.errors.hasErrors === true">
						<ul>
							<li class="error" ng-if="param.errors.type.unique === true">
								Type needs to be unique
							</li>
							<li class="error" ng-if="param.errors.type.minLength === true">
								Type cannot be less then 2 characters
							</li>
							<li class="error" ng-if="param.errors.type.valid === true">
								Type is not valid
							</li>
						</ul>
					</div>
				</div>
				<div ng-if="key === 'allowNull'" class="row" style="margin-left:25px;padding-top:5px;">
					<div class="col-xs-12 col-sm-2 checkbox">
						<label>
							<input type="checkbox" ng-model="param.params[key]"><strong>Allow Null</strong>
						</label>
					</div>

				</div>
				<span ng-if="key === 'properties'">
					<div class="row" style="margin-left:25px;padding-top:5px;">
						<div>Properties: minLength,maxLength,enum(|),minArraylength,arrayItemType,commaSeparatedInts</div>
					</div>
					<div class="row" style="margin-left:25px;padding-top:5px;">
						<div class="col-xs-6 col-sm-2">
							<strong>Properties</strong>
						</div>
						<div class="col-xs-6 col-sm-2">
							<button ng-click="addNewProperty(param.params[key])" type="button" class="btn btn-success btn-xs">
								Add New Property
							</button>
						</div>
					</div>
					<div class="row" style="margin-left:25px;padding-top:5px;">
						<div class="col-xs-12 col-sm-8">
							<table class="table table-condensed table-responsive">
								<thead>
									<tr>
										<th>Name</th>
										<th>Value</th>
										<th></th>
										<th></th>
									</tr>
								</thead>
								<tbody>
									<tr ng-repeat="property in value">
										<td>
											<input type="text" class="form-control input-sm" ng-class="{'error': property.errors.name.hasErrors === true}" ng-model="property.name" ng-model-options="{ debounce: 200 }" ng-change="validateParams()">
										</td>
										<td>
											<input type="text" class="form-control input-sm" ng-class="{'error': property.errors.value.hasErrors === true}" ng-model="property.value" ng-model-options="{ debounce: 200 }" ng-change="validateParams()">
										</td>
										<td>
											<ul>
												<li class="error" ng-if="property.errors.name.unique === true">
													Name needs to be unique
												</li>
												<li class="error" ng-if="property.errors.name.minLength === true">
													Name cannot be less then 2 characters
												</li>
												<li class="error" ng-if="property.errors.name.valid === true">
													Name is not valid
												</li>
												<li class="error" ng-if="property.errors.value.minLength === true">
													Value cannot be blank
												</li>
												<li class="error" ng-if="property.errors.value.valid === true">
													Value is not valid
												</li>
											</ul>
										</td>
										<td>
										<td>
											<button ng-click="deleteProperty(value,$index)" type="button" class="btn btn-danger btn-xs" style="margin-top:8px;">
												Delete
											</button>
										</td>
										</td>
									</tr>
								</tbody>
							</table>
						</div>
					</div>
				</span>
				<span ng-if="key === 'required'">
					<div class="row" style="margin-left:25px;padding-top:5px;">
						<div class="col-xs-6 col-sm-2">
							<strong>Required</strong>
						</div>
						<div class="col-xs-6 col-sm-2">
							<button ng-click="addNewRequired(param.params[key])" type="button" class="btn btn-success btn-xs">
								Add New Required
							</button>
						</div>
					</div>
					<div class="row" style="margin-left:25px;padding-top:5px;">
						<div class="col-xs-12 col-sm-8">
							<table class="table table-condensed table-responsive">
								<thead>
									<tr>
										<th>Controller</th>
										<th>Function</th>
										<th>Method</th>
										<th></th>
										<th></th>
									</tr>
								</thead>
								<tbody>
									<tr ng-repeat="required in value">
										<td>
											<input type="text" class="form-control input-sm" ng-class="{'error': required.errors.controller.hasErrors === true}" ng-model="required.controller" ng-model-options="{ debounce: 200 }" ng-change="validateParams()">
										</td>
										<td>
											<input type="text" class="form-control input-sm" ng-class="{'error': required.errors.function.hasErrors === true}" ng-model="required.function" ng-model-options="{ debounce: 200 }" ng-change="validateParams()">
										</td>
										<td>
											<select class="form-control" ng-class="{'error': required.errors.method.hasErrors === true}" ng-model="required.method" ng-change="validateParams()">
												<option value="get">get</option>
												<option value="post">post</option>
												<option value="put">put</option>
												<option value="delete">delete</option>
											</select>
										</td>
										<td>
											<ul>
												<li class="error" ng-if="required.errors.unique === true">
													Controller-Function-Method is not unique
												</li>
												<li class="error" ng-if="required.errors.controller.minLength === true">
													Controller cannot be less then 2 characters
												</li>
												<li class="error" ng-if="required.errors.controller.valid === true">
													Controller is not valid
												</li>
												<li class="error" ng-if="required.errors.function.minLength === true">
													Function cannot be less then 2 characters
												</li>
												<li class="error" ng-if="required.errors.function.valid === true">
													Function is not valid
												</li>
											</ul>
										</td>
										<td>
										<td>
											<button ng-click="deleteRequired(value,$index)" type="button" class="btn btn-danger btn-xs" style="margin-top:8px;">
												Delete
											</button>
										</td>
										</td>
									</tr>
								</tbody>
							</table>
						</div>
					</div>
				</span>
				<span ng-if="key === 'exclude'">
					<div class="row" style="margin-left:25px;padding-top:5px;">
						<div class="col-xs-6 col-sm-2">
							<strong>Exclude</strong>
						</div>
						<div class="col-xs-6 col-sm-2">
							<button ng-click="addNewExclude(param.params[key])" type="button" class="btn btn-success btn-xs">
								Add New Exclude
							</button>
						</div>
					</div>
					<div class="row" style="margin-left:25px;padding-top:5px;">
						<div class="col-xs-12 col-sm-8">
							<table class="table table-condensed table-responsive">
								<thead>
									<tr>
										<th>Controller</th>
										<th>Function</th>
										<th>Method</th>
										<th></th>
										<th></th>
									</tr>
								</thead>
								<tbody>
									<tr ng-repeat="exclude in value">
										<td>
											<input type="text" class="form-control input-sm" ng-class="{'error': exclude.errors.controller.hasErrors === true}" ng-model="exclude.controller" ng-model-options="{ debounce: 200 }" ng-change="validateParams()">
										</td>
										<td>
											<input type="text" class="form-control input-sm" ng-class="{'error': exclude.errors.function.hasErrors === true}" ng-model="exclude.function" ng-model-options="{ debounce: 200 }" ng-change="validateParams()">
										</td>
										<td>
											<select class="form-control" ng-class="{'error': exclude.errors.method.hasErrors === true}" ng-model="exclude.method" ng-change="validateParams()">
												<option value="get">get</option>
												<option value="post">post</option>
												<option value="put">put</option>
												<option value="delete">delete</option>
											</select>
										</td>
										<td>
											<ul>
												<li class="error" ng-if="exclude.errors.unique === true">
													Controller-Function-Method is not unique
												</li>
												<li class="error" ng-if="exclude.errors.controller.minLength === true">
													Controller cannot be less then 2 characters
												</li>
												<li class="error" ng-if="exclude.errors.controller.valid === true">
													Controller is not valid
												</li>
												<li class="error" ng-if="exclude.errors.function.minLength === true">
													Function cannot be less then 2 characters
												</li>
												<li class="error" ng-if="exclude.errors.function.valid === true">
													Function is not valid
												</li>
											</ul>
										</td>
										<td>
										<td>
											<button ng-click="deleteExclude(value,$index)" type="button" class="btn btn-danger btn-xs" style="margin-top:8px;">
												Delete
											</button>
										</td>
										</td>
									</tr>
								</tbody>
							</table>
						</div>
					</div>
				</span>
				<span ng-if="key === 'novalidate'">
					<div class="row" style="margin-left:25px;padding-top:5px;">
						<div class="col-xs-6 col-sm-2">
							<strong>Novalidate</strong>
						</div>
						<div class="col-xs-6 col-sm-2">
							<button ng-click="addNewNovalidate(param.params[key])" type="button" class="btn btn-success btn-xs">
								Add New Novalidate
							</button>
						</div>
					</div>
					<div class="row" style="margin-left:25px;padding-top:5px;">
						<div class="col-xs-12 col-sm-8">
							<table class="table table-condensed table-responsive">
								<thead>
									<tr>
										<th>Controller</th>
										<th>Function</th>
										<th>Method</th>
										<th></th>
										<th></th>
									</tr>
								</thead>
								<tbody>
									<tr ng-repeat="novalidate in value">
										<td>
											<input type="text" class="form-control input-sm" ng-class="{'error': novalidate.errors.controller.hasErrors === true}" ng-model="novalidate.controller" ng-model-options="{ debounce: 200 }" ng-change="validateParams()">
										</td>
										<td>
											<input type="text" class="form-control input-sm" ng-class="{'error': novalidate.errors.function.hasErrors === true}" ng-model="novalidate.function" ng-model-options="{ debounce: 200 }" ng-change="validateParams()">
										</td>
										<td>
											<select class="form-control" ng-class="{'error': novalidate.errors.method.hasErrors === true}" ng-model="novalidate.method" ng-change="validateParams()">
												<option value="get">get</option>
												<option value="post">post</option>
												<option value="put">put</option>
												<option value="delete">delete</option>
											</select>
										</td>
										<td>
											<ul>
												<li class="error" ng-if="novalidate.errors.unique === true">
													Controller-Function-Method is not unique
												</li>
												<li class="error" ng-if="novalidate.errors.controller.minLength === true">
													Controller cannot be less then 2 characters
												</li>
												<li class="error" ng-if="novalidate.errors.controller.valid === true">
													Controller is not valid
												</li>
												<li class="error" ng-if="novalidate.errors.function.minLength === true">
													Function cannot be less then 2 characters
												</li>
												<li class="error" ng-if="novalidate.errors.function.valid === true">
													Function is not valid
												</li>
											</ul>
										</td>
										<td>
										<td>
											<button ng-click="deleteNovalidate(value,$index)" type="button" class="btn btn-danger btn-xs" style="margin-top:8px;">
												Delete
											</button>
										</td>
										</td>
									</tr>
								</tbody>
							</table>
						</div>
					</div>
				</span>
			</span>
		</span>
		<pre>{{validator | json}}</pre>
		<hr>
	</div>

	<!-- jQuery Version 1.11.1 -->
	<script src="js/jquery.js"></script>
	<!-- <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.4.2/jquery.min.js"></script> -->

	<!-- Bootstrap Core JavaScript -->
	<script src="js/bootstrap.min.js"></script>

	<!-- angular Version 1.6.9 -->
	<script src="js/angular/1.6.9/angular.min.js"></script>
	<script type="text/javascript" src="js/validators.js"></script>

	<!-- angular-ui-bootstrap-2.2.0 -->
	<script src="js/angular/uibootstrap/2.5.0/uibootstrap.min.js"></script>


</body>

</html>