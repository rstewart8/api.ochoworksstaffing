var app = angular.module('app', ['ui.bootstrap']);


//// Controllers ////

app.controller('adminCtrl', function($rootScope,$scope,$location,$uibModal,$log,$window,$http) {

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




