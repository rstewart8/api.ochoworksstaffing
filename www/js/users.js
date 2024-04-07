var app = angular.module('app', ['ui.bootstrap']);


//// Controllers ////

app.controller('userCtrl', function($rootScope,$scope,$location,$uibModal,$log,$window,$http) {

	$scope.init = function (settings) {
		settings = window[settings];
		$rootScope.users = settings.users;
	};

	$scope.deleteUser = function(userId){
		var r = confirm("Are you sure you want to delete this user?");
	    if (r == true) {
	        var userData = {
				which: 'deleteUser',
				id: userId
			}
			$http({
		        url:'/apiUsers',
		        method : 'DELETE',
		        headers: {
		            'Content-Type': 'application/json'
		          },
		        data: userData
		    }).then(function successCallback(response) {
		    	if (response.data.status !== 'ok') {
	    			alert("Unable to delete user. "+response.data.msg);
		    	} else {
					$window.location.href = '/apiUsers';
				}
			}, function errorCallback(response) {
				alert("Error deleting user.");
			});
	    } else {

	    }
		
		validateRoutes.validate();
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

	$scope.open = function (which,param1,param2,param3) {
		var modalInstance = $uibModal.open({
			animation: false,
			ariaLabelledBy: 'modal-title',
			ariaDescribedBy: 'modal-body',
			templateUrl: which+'.html',
			controller: which+'Ctrl',
			resolve: {
				items: function () {
					return { 
						param1: param1,
						param2: param2,
						param3: param3 
					};
				}
			}
		});

		modalInstance.result.then(function () {
			
		}, function () {
			$log.info('Modal dismissed at: ' + new Date());
		});
	};

	$scope.edit = function (which,param1,param2,param3) {
		console.log("which: "+which+" param1: "+param1)
		var modalInstance = $uibModal.open({
			animation: false,
			ariaLabelledBy: 'modal-title',
			ariaDescribedBy: 'modal-body',
			templateUrl: which+'.html',
			controller: which+'Ctrl',
			resolve: {
				items: function () {
					return { 
						param1: param1,
						param2: param2,
						param3: param3 
					};
				}
			}
		});

		modalInstance.result.then(function () {
			
		}, function () {
			$log.info('Modal dismissed at: ' + new Date());
		});
	};

});

app.controller('userFormCtrl', function ($rootScope, $scope, $uibModalInstance, items, $log, $q,$http,$window) {
	$scope.user = {};
	$scope.user.status = 'active';

	$scope.passwordChange = function(form){
		$scope.userForm.passwordConfirm.$setValidity("passwordmatch", true);
		if ($scope.user.password !== $scope.user.passwordConfirm) {
			$scope.userForm.passwordConfirm.$setValidity("passwordmatch", false);
		}
	};

	$scope.save = function(){
		var userData = {
			which: 'create',
			username: $scope.user.username,
			status: $scope.user.status,
			password: $scope.user.password,
			confirm: $scope.user.passwordConfirm
		}
		$http({
	        url:'/apiUsers',
	        method : 'POST',
	        headers: {
	            'Content-Type': 'application/json'
	          },
	        data: userData
	    }).then(function successCallback(response) {
	    	if (response.data.status !== 'ok') {
	    		alert("Unable to create user. "+response.data.msg);
	    	} else {
				$window.location.href = '/apiUsers';
			}
		}, function errorCallback(response) {
			alert("Error Saving User");
			$uibModalInstance.dismiss('cancel');
		});
	}

	$scope.cancel = function () {
		$uibModalInstance.dismiss('cancel');
	};
});

app.controller('editFormCtrl', function ($rootScope, $scope, $uibModalInstance, items, $log, $q,$http,$window) {
	$scope.user = items.param1;

	$scope.passwordChange = function(form){
		$scope.userForm.passwordConfirm.$setValidity("passwordmatch", true);
		if ($scope.user.password !== $scope.user.passwordConfirm) {
			$scope.userForm.passwordConfirm.$setValidity("passwordmatch", false);
		}
	};

	$scope.save = function(){
		var userData = {
			which: 'update',
			id: $scope.user.id,
			username: $scope.user.username,
			status: $scope.user.status,
			password: $scope.user.password,
			confirm: $scope.user.passwordConfirm
		}
		$http({
	        url:'/apiUsers',
	        method : 'PUT',
	        headers: {
	            'Content-Type': 'application/json'
	          },
	        data: userData
	    }).then(function successCallback(response) {
	    	
	    	if (response.data.status !== 'ok') {
	    		alert("Unable to edit user. "+response.data.msg);
	    	}
			$window.location.href = '/apiUsers';
		}, function errorCallback(response) {
			alert("Error Saving User");
			$uibModalInstance.dismiss('cancel');
			$window.location.href = '/apiUsers';
		});
	}

	$scope.cancel = function () {
		$uibModalInstance.dismiss('cancel');
		$window.location.href = '/apiUsers';
	};
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


//// Services End ////

function isValidPassword(str) {
	var isValidPassword = /^(?=.*[\d])(?=.*[A-Z])(?=.*[a-z])(?=.*[!@#$%^&*])[\w!@#$%^&*]{8,}$/;
	return isValidPassword.test(str);
}

function isValidName(name){
	var hasWhiteSpace = /\s/;

	if (hasWhiteSpace.test(name)) {
		return false;
	}

	var validName = /^[$A-Z_][0-9A-Z_$]*$/i;
	return validName.test(name);
}




