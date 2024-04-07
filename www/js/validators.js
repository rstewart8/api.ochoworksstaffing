var app = angular.module('app', ['ui.bootstrap']);

//// Controllers ////

app.controller('validatorCtrl', function($rootScope,$scope,$anchorScroll,$location,$uibModal,$log,$window,$http,validateValidator) {

	$rootScope.validator = {};
	$scope.fileName = '';
	$rootScope.isValidValidator = false;
	$scope.newParam = {
		name: null,
		errors: {
			hasErrors: false,
			unique: false,
			minLength: false,
			valid: false
		}
	};
	$scope.newValidator = {
		name: null,
		errors: {
			hasErrors: false,
			unique: false,
			minLength: false,
			valid: false
		}
	};

	$scope.logOut = function(){
		var userData = {
			which: 'logOut'
		}
		$http({
	        url:'/apiUsers',
	        method : 'POST',
	        headers: {
	            'Content-Type': 'application/json'
	          },
	        data: userData
	    }).then(function successCallback(response) {
	    	$window.location.href = '/apiLogin';
		}, function errorCallback(response) {
			alert("Error logging Out.");
			$uibModalInstance.dismiss('cancel');
		});
	}

	$scope.validateParams = function(){
		validateValidator.validate();
	};

	$scope.init = function (settings) {
		settings = window[settings];
		$rootScope.fileNames = settings.fileNames;
	};

	$scope.getFile = function(file){
		$scope.file = file;
		$scope.fileName = file+'.json';
		var data = {
			which: 'getValidator',
			fileName: file
		}
		$http({
	        url:'/apiValidators',
	        method : 'POST',
	        headers: {
	            'Content-Type': 'application/json'
	          },
	        data: data
	    }).then(function successCallback(response) {
	    	$rootScope.validator = response.data.data;
	    	$scope.validateParams();
		}, function errorCallback(response) {
			alert("Error getting validator.");
		});
	}

	$scope.publishValidator = function(){
		var r = confirm("Are you sure you want to publish validator?");
	    if (r == true) {
			var data = {
				which: 'publishValidator',
				json: $rootScope.validator,
				fileName: $scope.fileName
			}
			$http({
		        url:'/apiValidators',
		        method : 'POST',
		        headers: {
		            'Content-Type': 'application/json'
		          },
		        data: data
		    }).then(function successCallback(response) {
		    	$window.location.href = '/apiValidators';
			}, function errorCallback(response) {
				alert("Error publising validator.");
			});
		}
	}

	$scope.validatorTemplate = function(){
		$rootScope.validator = {
			params: [{
				name: null,
				params: {
					type: null,
					allowNull: false,
					properties: [],
					required: [],
					exclude: [],
					novalidate: []
				}
			}]
		}
	}


	$scope.resetPage = function(){
		var r = confirm("Are you sure you want to delete reset validator?");
	    if (r == true) {

	    	if ($rootScope.fileNames.indexOf($scope.file) > -1) {
	    		$scope.getFile($scope.file);
	    	} else {
	    		$scope.validatorTemplate();
	    	}

	        
	    }
	}


	$scope.addNewValidator = function(){
		$scope.file = $scope.newValidator.name;
		$scope.fileName = $scope.newValidator.name+'.json';

		$scope.validatorTemplate();
		$scope.validateParams();
	}

	$scope.validateNewValidator = function(){

		var v = $scope.newValidator.errors;

		v.hasErrors = false;
		v.unique = false;
		v.valid = false;
		v.minLength = false;

		if ($scope.newValidator.name.length < 1) {
			return;
		}

		if ($rootScope.fileNames.indexOf($scope.newValidator.name) > -1) {
			v.hasErrors = true;
			v.unique = true;
		}

		if ($scope.newValidator.name.length < 2) {
			v.hasErrors = true;
			v.minLength = true;
		}

		if (isValidName($scope.newValidator.name) === false) {
			v.hasErrors = true;
			v.valid = true;
		}

	}

	$scope.validateNewParam = function(){

		var v = $scope.newParam.errors;

		v.hasErrors = false;
		v.unique = false;
		v.valid = false;
		v.minLength = false;

		if ($scope.newParam.name.length < 1) {
			return;
		}

		angular.forEach($rootScope.validator.params,function(param){
			if (param.name === $scope.newParam.name) {
				v.hasErrors = true;
				v.unique = true;
			}
		});

		if ($scope.newParam.name.length < 2) {
			v.hasErrors = true;
			v.minLength = true;
		}

		if (isValidName($scope.newParam.name) === false) {
			v.hasErrors = true;
			v.valid = true;
		}

	}

	$scope.addNewParam = function(){
		$rootScope.validator.params.push({
			name: $scope.newParam.name,
			params: {
				type: '',
				allowNull: false,
				properties: [],
				required: [],
				exclude: [],
				novalidate: []
			}
		});
		$scope.newParam.name = '';
		$scope.validateParams();
	}

	$scope.deleteFile = function(file){
		var r = confirm("Are you sure you want to delete this validator?");
	    if (r == true) {
	    	var data = {
				which: 'deleteValidator',
				fileName: file
			}
	        $http({
		        url:'/apiValidators',
		        method : 'POST',
		        headers: {
		            'Content-Type': 'application/json'
		          },
		        data: data
		    }).then(function successCallback(response) {
		    	$window.location.href = '/apiValidators';
			}, function errorCallback(response) {
				alert("Error deleting validator.");
			});
	    } 
	}

	$scope.deleteParam = function(index) {
		var r = confirm("Are you sure you want to delete this param?");
	    if (r == true) {
	        $rootScope.validator.params.splice(index, 1);
	        $scope.validateParams();
	    } 
	}

	$scope.addNewProperty = function(param) {
		param.push({name: '',value:null});
		$scope.validateParams();
	}

	$scope.addNewRequired = function(param) {
		param.push({controller: '',function: '',method: 'get'});
		$scope.validateParams();
	}

	$scope.addNewExclude = function(param) {
		param.push({controller: '',function: '',method: 'get'});
		$scope.validateParams();
	}

	$scope.addNewNovalidate = function(param) {
		param.push({controller: '',function: '',method: 'get'});
		$scope.validateParams();
	}

	$scope.deleteProperty = function(property,index) {
		var r = confirm("Are you sure you want to delete this property?");
	    if (r == true) {
	        property.splice(index, 1);
	        $scope.validateParams();
	    } 
	}

	$scope.deleteRequired = function(property,index) {
		var r = confirm("Are you sure you want to delete this required?");
	    if (r == true) {
	        property.splice(index, 1);
	        $scope.validateParams();
	    } 
	}

	$scope.deleteExclude = function(property,index) {
		var r = confirm("Are you sure you want to delete this exclude?");
	    if (r == true) {
	        property.splice(index, 1);
	        $scope.validateParams();
	    } 
	}

	$scope.deleteNovalidate = function(property,index) {
		var r = confirm("Are you sure you want to delete this novalidate?");
	    if (r == true) {
	        property.splice(index, 1);
	        $scope.validateParams();
	    } 
	}
	
});

//// Controllers End ////

//// Filters ////
app.filter('capitalize', function() {
	//// Capitalize first lettter of string ////
    return function(input) {
      return (!!input) ? input.charAt(0).toUpperCase() + input.substr(1).toLowerCase() : '';
    }
});

////Filters End ////

//// Directives ////


//// Directives End ////

//// Services ////

app.service('validateValidator', function($rootScope) {

	this.validate = function() {
		var duplicateParams = [];
		var params = [];

		$rootScope.isValidValidator = true;

		angular.forEach($rootScope.validator.params,function(param){
			if (params.indexOf(param.name) > -1) {
				duplicateParams.push(param.name)
			} else {
				params.push(param.name)
			}
		});

		angular.forEach($rootScope.validator.params,function(param){
			if (param.errors === undefined) {
				param.errors = {
					type: {},
					properties: {},
					required: {},
					exclude: {},
					novalidate: {}
				};
			}

			param.errors.hasErrors = false;
			param.errors.minLength = false;
			param.errors.valid = false;
			param.errors.type.hasErrors = false;
			param.errors.type.minLength = false;
			param.errors.properties.hasErrors = false;
			param.errors.required.hasErrors = false;
			param.errors.exclude.hasErrors = false;
			param.errors.novalidate.hasErrors = false;

			if (duplicateParams.indexOf(param.name) > -1) {
				param.errors.hasErrors = true;
				param.errors.unique = true;
			}

			if (param.name === null || param.name === '' || param.name.length < 2) {
				param.errors.hasErrors = true;
				param.errors.minLength = true;
			}

			if (isValidName(param.name) === false) {
				param.errors.hasErrors = true;
				param.errors.valid = true;
			} 

			angular.forEach(param.params,function(v1,k1){
				if (k1 === 'type') {
					if (v1 === null || v1 === '' || v1.length < 2 ) {
						param.errors.hasErrors = true;
						param.errors.type.hasErrors = true;
						param.errors.type.minLength = true;
					}
					if (isValidName(v1) === false ) {
						param.errors.hasErrors = true;
						param.errors.type.hasErrors = true;
						param.errors.type.valid = true;
					}
				}

				if (k1 === 'properties') {
					var properties = [];
					var duplicateProperties = [];

					angular.forEach(v1,function(v2){

						if (properties.indexOf(v2.name) < 0) {
							properties.push(v2.name);
						} else {
							duplicateProperties.push(v2.name);
						}

						if (v2.errors === undefined) {
							v2.errors = {
								name: {},
								value: {}
							};
						}

						v2.errors.hasErrors = false;

						v2.errors.name.hasErrors = false;
						v2.errors.name.unique = false;
						v2.errors.name.minLength = false;
						v2.errors.name.valid = false;

						v2.errors.value.hasErrors = false;
						v2.errors.value.minLength = false;
						v2.errors.value.valid = false;

						if (v2.name.length < 2 ) {
							param.errors.hasErrors = true;
							param.errors.properties.hasErrors = true;
							v2.errors.hasErrors = true;
							v2.errors.name.hasErrors = true;
							v2.errors.name.minLength = true;
						}
						if (isValidName(v2.name) === false ) {
							param.errors.hasErrors = true;
							param.errors.properties.hasErrors = true;
							v2.errors.hasErrors = true;
							v2.errors.name.hasErrors = true;
							v2.errors.name.valid = true;
						}
						
						if (v2.value === null || v2.value === '') {
							param.errors.hasErrors = true;
							param.errors.properties.hasErrors = true;
							v2.errors.hasErrors = true;
							v2.errors.value.hasErrors = true;
							v2.errors.value.minLength = true;
						}
						if (isValidValue(v2.value) === false ) {
							param.errors.hasErrors = true;
							param.errors.properties.hasErrors = true;
							v2.errors.hasErrors = true;
							v2.errors.value.hasErrors = true;
							v2.errors.value.valid = true;
						}
					});

					angular.forEach(v1,function(v2){
						if (duplicateProperties.indexOf(v2.name) > -1) {
							param.errors.hasErrors = true;
							param.errors.properties.hasErrors = true;
							v2.errors.hasErrors = true;
							v2.errors.name.hasErrors = true;
							v2.errors.name.unique = true;
						}
					});
				}

				if (k1 === 'required') {
					var routes = [];
					var duplicateRoutes = [];

					angular.forEach(v1,function(v2){

						var route = v2.controller+v2.function+v2.method;

						if (routes.indexOf(route) < 0) {
							routes.push(route);
						} else {
							duplicateRoutes.push(route);
						}

						if (v2.errors === undefined) {
							v2.errors = {
								controller: {},
								function: {},
								method: {}
							};
						}

						v2.errors.hasErrors = false;
						v2.errors.unique = false;

						v2.errors.controller.hasErrors = false;
						v2.errors.controller.minLength = false;
						v2.errors.controller.valid = false;

						v2.errors.function.hasErrors = false;
						v2.errors.function.minLength = false;
						v2.errors.function.valid = false;

						v2.errors.method.hasErrors = false;

						if (v2.controller.length < 2 ) {
							param.errors.hasErrors = true;
							param.errors.properties.hasErrors = true;
							v2.errors.hasErrors = true;
							v2.errors.controller.hasErrors = true;
							v2.errors.controller.minLength = true;
						}
						if (isValidName(v2.controller) === false ) {
							param.errors.hasErrors = true;
							param.errors.properties.hasErrors = true;
							v2.errors.hasErrors = true;
							v2.errors.controller.hasErrors = true;
							v2.errors.controller.valid = true;
						}
						
						if (v2.function.length < 2 ) {
							param.errors.hasErrors = true;
							param.errors.properties.hasErrors = true;
							v2.errors.hasErrors = true;
							v2.errors.function.hasErrors = true;
							v2.errors.function.minLength = true;
						}
						if (isValidName(v2.function) === false ) {
							param.errors.hasErrors = true;
							param.errors.properties.hasErrors = true;
							v2.errors.hasErrors = true;
							v2.errors.function.hasErrors = true;
							v2.errors.function.valid = true;
						}
					});

					angular.forEach(v1,function(v2){
						var route = v2.controller+v2.function+v2.method;
						
						if (duplicateRoutes.indexOf(route) > -1) {
							param.errors.hasErrors = true;
							param.errors.required.hasErrors = true;
							v2.errors.hasErrors = true;
							v2.errors.unique = true;
							v2.errors.controller.hasErrors = true;
							v2.errors.function.hasErrors = true;
							v2.errors.method.hasErrors = true;
 						}
					});
				}

				if (k1 === 'exclude') {
					var routes = [];
					var duplicateRoutes = [];

					angular.forEach(v1,function(v2){

						var route = v2.controller+v2.function+v2.method;

						if (routes.indexOf(route) < 0) {
							routes.push(route);
						} else {
							duplicateRoutes.push(route);
						}

						if (v2.errors === undefined) {
							v2.errors = {
								controller: {},
								function: {},
								method: {}
							};
						}

						v2.errors.hasErrors = false;
						v2.errors.unique = false;

						v2.errors.controller.hasErrors = false;
						v2.errors.controller.minLength = false;
						v2.errors.controller.valid = false;

						v2.errors.function.hasErrors = false;
						v2.errors.function.minLength = false;
						v2.errors.function.valid = false;

						v2.errors.method.hasErrors = false;

						if (v2.controller.length < 2 ) {
							param.errors.hasErrors = true;
							param.errors.properties.hasErrors = true;
							v2.errors.hasErrors = true;
							v2.errors.controller.hasErrors = true;
							v2.errors.controller.minLength = true;
						}
						if (isValidName(v2.controller) === false ) {
							param.errors.hasErrors = true;
							param.errors.properties.hasErrors = true;
							v2.errors.hasErrors = true;
							v2.errors.controller.hasErrors = true;
							v2.errors.controller.valid = true;
						}
						
						if (v2.function.length < 2 ) {
							param.errors.hasErrors = true;
							param.errors.properties.hasErrors = true;
							v2.errors.hasErrors = true;
							v2.errors.function.hasErrors = true;
							v2.errors.function.minLength = true;
						}
						if (isValidName(v2.function) === false ) {
							param.errors.hasErrors = true;
							param.errors.properties.hasErrors = true;
							v2.errors.hasErrors = true;
							v2.errors.function.hasErrors = true;
							v2.errors.function.valid = true;
						}
					});

					angular.forEach(v1,function(v2){
						var route = v2.controller+v2.function+v2.method;
						
						if (duplicateRoutes.indexOf(route) > -1) {
							param.errors.hasErrors = true;
							param.errors.required.hasErrors = true;
							v2.errors.hasErrors = true;
							v2.errors.unique = true;
							v2.errors.controller.hasErrors = true;
							v2.errors.function.hasErrors = true;
							v2.errors.method.hasErrors = true;
 						}
					});
				}

				if (k1 === 'novalidate') {
					var routes = [];
					var duplicateRoutes = [];

					angular.forEach(v1,function(v2){

						var route = v2.controller+v2.function+v2.method;

						if (routes.indexOf(route) < 0) {
							routes.push(route);
						} else {
							duplicateRoutes.push(route);
						}

						if (v2.errors === undefined) {
							v2.errors = {
								controller: {},
								function: {},
								method: {}
							};
						}

						v2.errors.hasErrors = false;
						v2.errors.unique = false;

						v2.errors.controller.hasErrors = false;
						v2.errors.controller.minLength = false;
						v2.errors.controller.valid = false;

						v2.errors.function.hasErrors = false;
						v2.errors.function.minLength = false;
						v2.errors.function.valid = false;

						v2.errors.method.hasErrors = false;

						if (v2.controller.length < 2 ) {
							param.errors.hasErrors = true;
							param.errors.properties.hasErrors = true;
							v2.errors.hasErrors = true;
							v2.errors.controller.hasErrors = true;
							v2.errors.controller.minLength = true;
						}
						if (isValidName(v2.controller) === false ) {
							param.errors.hasErrors = true;
							param.errors.properties.hasErrors = true;
							v2.errors.hasErrors = true;
							v2.errors.controller.hasErrors = true;
							v2.errors.controller.valid = true;
						}
						
						if (v2.function.length < 2 ) {
							param.errors.hasErrors = true;
							param.errors.properties.hasErrors = true;
							v2.errors.hasErrors = true;
							v2.errors.function.hasErrors = true;
							v2.errors.function.minLength = true;
						}
						if (isValidName(v2.function) === false ) {
							param.errors.hasErrors = true;
							param.errors.properties.hasErrors = true;
							v2.errors.hasErrors = true;
							v2.errors.function.hasErrors = true;
							v2.errors.function.valid = true;
						}
					});

					angular.forEach(v1,function(v2){
						var route = v2.controller+v2.function+v2.method;
						
						if (duplicateRoutes.indexOf(route) > -1) {
							param.errors.hasErrors = true;
							param.errors.required.hasErrors = true;
							v2.errors.hasErrors = true;
							v2.errors.unique = true;
							v2.errors.controller.hasErrors = true;
							v2.errors.function.hasErrors = true;
							v2.errors.method.hasErrors = true;
 						}
					});
				}
			});
			if (param.errors.hasErrors === true) {
				$rootScope.isValidValidator = false;
			}
		});
	}
});

//// Services End ////

function isValidName(name){
	var hasWhiteSpace = /\s/;

	if (hasWhiteSpace.test(name)) {
		return false;
	}

	var validName = /^[$A-Z_][0-9A-Z_$]*$/i;
	return validName.test(name);
}

function isValidValue(value){

	var hasWhiteSpace = /\s/;

	if (hasWhiteSpace.test(value)) {
		return false;
	}

	var validName = /^[$0-9A-Z_|][0-9A-Z_|$]*$/i;
	return validName.test(value);
}




