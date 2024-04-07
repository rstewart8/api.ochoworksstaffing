var app = angular.module('app', ['ui.bootstrap']);

app.run(['$anchorScroll', function($anchorScroll) {
    $anchorScroll.yOffset = 55; // always scroll by 50 extra pixels
}]);

//// Controllers ////

app.controller('routeCtrl', function($rootScope, $scope, $anchorScroll, $location, $uibModal, $log, validateRoutes, $window, $http) {

    $rootScope.routes = [];
    $rootScope.validRoutes = false;
    $rootScope.controllers = [];
    $scope.errors = [];
    $scope.paramTypes = ['json', 'form'];
    $scope.showIdentitys = false;

    $scope.logOut = function() {
        var userData = {
            which: 'logOut'
        }
        $http({
            url: '/apiUsers',
            method: 'POST',
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

    $scope.init = function(settings) {
        settings = window[settings];
        $rootScope.routes = settings.routes;
        $rootScope.json = settings.json;
        $rootScope.rolePermissions = settings.rolePermissions;
        $rootScope.identitys = settings.identitys;
        $rootScope.requestMethodTypes = settings.requestMethodTypes;
        angular.forEach($rootScope.routes, function(route) {
            $rootScope.controllers.push(route.name);
        });

        $scope.validateRoute();

        // $scope.oriRoutes = tmpRoutes;
    };

    $scope.rolePermissionsChange = function(method) {
        if (method.permissions === true) {
            $scope.showIdentitys = true;
            method.role_permissions = {};
            angular.forEach($rootScope.rolePermissions, function(role) {
                method['role_permissions'][role] = false;
            });

            method.identitys = {};
            angular.forEach($rootScope.identitys, function(role) {
                method['identitys'][role] = false;
            });
        } else {
            $scope.showIdentitys = false;
            delete method.role_permissions;
            delete method.identitys;
        }
    }

    $rootScope.goToAnchor = function(anchor) {
        var x = anchor;
        if (x === undefined) {
            x = $scope.selectedAnchor;
        }

        var newHash = 'anchor' + x;
        console.log("new hash " + newHash)
        if ($location.hash() !== newHash) {
            // set the $location.hash to `newHash` and
            // $anchorScroll will automatically scroll to it
            $location.hash('anchor' + x);
        } else {
            // call $anchorScroll() explicitly,
            // since $location.hash hasn't changed
            $anchorScroll();
        }
    };

    $scope.open = function(which, param1, param2, param3) {
        var modalInstance = $uibModal.open({
            animation: false,
            ariaLabelledBy: 'modal-title',
            ariaDescribedBy: 'modal-body',
            templateUrl: which + '.html',
            controller: which + 'Ctrl',
            resolve: {
                items: function() {
                    return {
                        param1: param1,
                        param2: param2,
                        param3: param3
                    };
                }
            }
        });

        modalInstance.result.then(function() {
            switch (which) {
                case 'addMethod':
                    $scope.resetAvailableMethods(param1, param2);
                    break;
                default:
            }
        }, function() {
            $log.info('Modal dismissed at: ' + new Date());
        });
    };

    $scope.resetAvailableMethods = function(routeIndex, functionIndex) {
        var types = [];
        angular.forEach($rootScope.requestMethodTypes, function(type) {
            types.push(type);
        });

        var func = $rootScope.routes[routeIndex].functions[functionIndex];

        func.availableMethods = types;
        angular.forEach(func.methods, function(method) {
            func.availableMethods.splice(func.availableMethods.indexOf(method.name), 1);
        });
    }

    $scope.addNewParam = function(controller, funct, meth) {
        angular.forEach($rootScope.routes, function(route) {
            if (route.name === controller) {
                angular.forEach(route.functions, function(func) {
                    if (func.name === funct) {
                        angular.forEach(func.methods, function(method) {
                            if (method.name === meth) {
                                route.errors.hasErrors = true;
                                func.errors.hasErrors = true;
                                method.errors.hasErrors = true;
                                method.params.push({
                                    name: null,
                                    type: null,
                                    required: false,
                                    errors: {
                                        hasErrors: true,
                                        invalidName: true,
                                        invalidType: true
                                    }
                                });
                                validateRoutes.validate();
                            }
                        });
                    }
                });
            }
        });
    }

    $scope.validateRoute = function() {
        validateRoutes.validate();
    };

    $scope.deleteRoute = function(index) {
        var r = confirm("Are you sure you want to delete this route?");
        if (r == true) {
            $rootScope.routes.splice(index, 1);
        } else {

        }

        validateRoutes.validate();
    };

    $scope.resetPage = function(index) {
        var r = confirm("Are you sure you want to reset this page?");
        if (r == true) {
            $window.location.reload();
        } else {

        }

    };

    $scope.deleteFunction = function(routeIndex, functionIndex) {
        var r = confirm("Are you sure you want to delete this function?");
        if (r == true) {
            $rootScope.routes[routeIndex].functions.splice(functionIndex, 1);
        } else {

        }

        validateRoutes.validate();
    };

    $scope.deleteMethod = function(routeIndex, functionIndex, methodIndex) {
        var r = confirm("Are you sure you want to delete this method?");
        if (r == true) {
            $rootScope.routes[routeIndex].functions[functionIndex].methods.splice(methodIndex, 1);
            $scope.resetAvailableMethods(routeIndex, functionIndex);
        } else {

        }

        validateRoutes.validate();
    };

    $scope.deleteParam = function(routeIndex, functionIndex, methodIndex, paramIndex) {
        var r = confirm("Are you sure you want to delete this param?");
        if (r == true) {
            $rootScope.routes[routeIndex].functions[functionIndex].methods[methodIndex].params.splice(paramIndex, 1);
        } else {

        }

        validateRoutes.validate();
    };

});

app.controller('addControllerCtrl', function($rootScope, $scope, $uibModalInstance, items, $log, $q, validateRoutes) {

    $scope.addControllerNameValid = false;
    $scope.addControllerNameChange = function() {
        if ($scope.addControllerName.length < 3) {
            $scope.addControllerNameValid = false;
            return;
        }

        if (!isValidName($scope.addControllerName)) {
            $scope.addControllerNameValid = false;
            return;
        }

        $scope.addControllerNameValid = true;
        angular.forEach($rootScope.controllers, function(controller) {
            if (controller === $scope.addControllerName) {
                $scope.addControllerNameValid = false;
            }
        });
    }

    $scope.addNewController = function() {

        $rootScope.controllers.push($scope.addControllerName);
        var newController = {
            errors: {
                hasErrors: false
            }
        }
        newController.name = $scope.addControllerName;

        $rootScope.routes.push(newController);
        validateRoutes.validate();

        $uibModalInstance.close();
    };

    $scope.cancel = function() {
        $uibModalInstance.dismiss('cancel');
    };
});

app.controller('addFunctionCtrl', function($rootScope, $scope, $uibModalInstance, items, $q, $log, validateRoutes) {

    $scope.addFunctionNameValid = false;
    $scope.addFunctionNameChange = function() {

        if ($scope.addFunctionName.length < 3) {
            $scope.addFunctionNameValid = false;
            return;
        }

        if (!isValidName($scope.addFunctionName)) {
            $scope.addFunctionNameValid = false;
            return;
        }

        $scope.addFunctionNameValid = true;
        $scope.controller = items.param1;

        angular.forEach($rootScope.routes, function(route) {
            if (route.name === $scope.controller) {
                if (route.functions !== undefined) {
                    angular.forEach(route.functions, function(func) {
                        if (func.name === $scope.addFunctionName) {
                            $scope.addFunctionNameValid = false;
                        }
                    });
                }
            }
        });
    }

    $scope.addNewFunction = function() {
        var newFunction = {
            name: $scope.addFunctionName,
            methods: [],
            availableMethods: [],
            errors: {
                hasErrors: false
            }
        }
        angular.forEach($rootScope.requestMethodTypes, function(type) {
            newFunction.availableMethods.push(type)
        });

        var controller = items.param1;

        angular.forEach($rootScope.routes, function(route) {
            if (route.name === controller) {
                if (route.functions === undefined) {
                    route.functions = [];
                }
                route.functions.push(newFunction);
                validateRoutes.validate();
            }
        });
        $uibModalInstance.close();
    };

    $scope.cancel = function() {
        $uibModalInstance.dismiss('cancel');
    };
});

app.controller('addMethodCtrl', function($rootScope, $scope, $uibModalInstance, items, $q, $log, validateRoutes) {

    $scope.availableMethods = [];

    var funct = $rootScope.routes[items.param1].functions[items.param2];
    $scope.availableMethods = funct.availableMethods;

    $scope.addNewMethod = function() {
        var newMethod = {
            name: $scope.addMethodName,
            authenticate: true,
            paramType: 'json',
            params: [],
            permissions: true,
            role_permissions: {},
            identitys: {},
            errors: {
                hasErrors: false
            }
        };

        angular.forEach($rootScope.rolePermissions, function(role) {
            newMethod['role_permissions'][role] = false;
        });
        $scope.showIdentitys = true;

        angular.forEach($rootScope.identitys, function(role) {
            newMethod['identitys'][role] = false;
        });

        funct.methods.push(newMethod);
        validateRoutes.validate();
        $uibModalInstance.close();
    };

    $scope.cancel = function() {
        $uibModalInstance.dismiss('cancel');
    };
});

app.controller('publishRouteCtrl', function($rootScope, $scope, $uibModalInstance, items, $q, $log, $http, $window) {

    $scope.isYes = function() {
        if ($scope.yes === 'yes') {
            return true;
        }
        return false;
    }

    $scope.publishRoutes = function() {
        $scope.showIdentitys = false;
        var userData = {
            which: 'publishRoute',
            json: $rootScope.routes
        }
        $http({
            url: '/apiRoutes',
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            data: userData
        }).then(function successCallback(response) {
            console.log("response: " + JSON.stringify(response))
            $uibModalInstance.dismiss('cancel');
            // $window.location.href = '/apiRoutes';
        }, function errorCallback(response) {
            console.log("failed response: " + JSON.stringify(response))
            alert("Error publising routes.");
            $uibModalInstance.dismiss('cancel');
        });
    }

    $scope.cancel = function() {
        $uibModalInstance.dismiss('cancel');
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

app.service('validateRoutes', function($rootScope) {

    this.validate = function() {
        var duplicateRoutes = [];

        var routes = $rootScope.controllers = [];

        angular.forEach($rootScope.routes, function(route, k1) {
            route.index = k1;
            if (routes.indexOf(route.name) > -1) {
                duplicateRoutes.push(route.name);
            } else {
                routes.push(route.name);
            }

            var functions = [];
            var duplicateFunctions = [];

            angular.forEach(route.functions, function(funct, k2) {
                funct.index = k2;
                if (functions.indexOf(funct.name) > -1) {
                    duplicateFunctions.push(funct.name);
                } else {
                    functions.push(funct.name);
                }

                angular.forEach(funct.methods, function(method, k3) {
                    method.index = k3;
                    if (method.errors === undefined) {
                        method.errors = {};
                    }

                    method.errors.hasErrors = false;

                    var paramNames = [];
                    var duplicateParamNames = [];
                    var invalidParamNames = [];
                    var invalidParamTypes = [];

                    angular.forEach(method.params, function(param, k4) {
                        param.index = k4;
                        if (param.name === 'files' && param.type !== 'binary' && method.paramType !== 'form') {
                            invalidParamNames.push(param.name);
                        }

                        if (param.type === 'binary' && param.name !== 'files') {
                            invalidParamTypes.push(param.type);
                        }

                        if (method.paramType !== 'form' && param.type === 'binary') {
                            invalidParamTypes.push(param.type);
                        }

                        if (paramNames.indexOf(param.name) > -1) {
                            duplicateParamNames.push(param.name);
                        } else {
                            paramNames.push(param.name)
                        }

                        if (param.name === undefined || param.name === '' || param.name === null) {
                            invalidParamNames.push(param.name)
                        }

                        if (isValidName(param.name) === false) {
                            invalidParamNames.push(param.name)
                        }

                        if (param.type === undefined || param.type === '' || param.type === null) {
                            invalidParamTypes.push(param.type)
                        }

                        if (isValidName(param.type) === false) {
                            invalidParamTypes.push(param.type)
                        }

                    });

                    angular.forEach(method.params, function(param) {
                        if (param.errors === undefined) {
                            param.errors = {};
                        }

                        param.errors.hasErrors = false;
                        param.errors.uniqueName = false;
                        param.errors.invalidName = false;
                        param.errors.invalidType = false;

                        if (duplicateParamNames.indexOf(param.name) > -1) {
                            param.errors.hasErrors = true;
                            param.errors.uniqueName = true;
                        }

                        if (invalidParamNames.indexOf(param.name) > -1) {
                            param.errors.hasErrors = true;
                            param.errors.invalidName = true;
                        }

                        if (invalidParamTypes.indexOf(param.type) > -1) {
                            param.errors.hasErrors = true;
                            param.errors.invalidType = true;
                        }

                    });
                });
            });

            angular.forEach(route.functions, function(funct) {
                if (funct.errors === undefined) {
                    funct.errors = {};
                }

                funct.errors.hasErrors = false;
                funct.errors.unique = false;
                funct.errors.minLength = false;
                funct.errors.valid = false;

                if (duplicateFunctions.indexOf(funct.name) > -1) {
                    funct.errors.hasErrors = true;
                    funct.errors.unique = true;
                }

                if (funct.name.length < 3) {
                    funct.errors.hasErrors = true;
                    funct.errors.minLength = true;
                }

                if (isValidName(funct.name) === false) {
                    funct.errors.hasErrors = true;
                    funct.errors.valid = true;
                }

            });
        });

        $rootScope.validRoutes = true;

        angular.forEach($rootScope.routes, function(route) {
            if (route.errors === undefined) {
                route.errors = {}
            }

            route.errors.hasErrors = false;
            route.errors.unique = false;
            route.errors.minLength = false;
            route.errors.valid = false;

            if (duplicateRoutes.indexOf(route.name) > -1) {
                route.errors.hasErrors = true;
                route.errors.unique = true;
                $rootScope.validRoutes = false;
            }

            if (route.name.length < 3) {
                route.errors.hasErrors = true;
                route.errors.minLength = true;
                $rootScope.validRoutes = false;
            }

            if (isValidName(route.name) === false) {
                route.errors.hasErrors = true;
                route.errors.valid = true;
                $rootScope.validRoutes = false;
            }

            angular.forEach(route.functions, function(funct) {
                if (funct.errors.hasErrors === true) {
                    route.errors.hasErrors = true;
                    $rootScope.validRoutes = false;
                }
                angular.forEach(funct.methods, function(method) {
                    angular.forEach(method.params, function(param) {
                        if (param.errors.hasErrors === true) {
                            funct.errors.hasErrors = true;
                            route.errors.hasErrors = true;
                            method.errors.hasErrors = true;
                            $rootScope.validRoutes = false;
                        }
                    });
                });
            });
        });
    }
});

//// Services End ////

function isValidName(name) {
    var hasWhiteSpace = /\s/;

    if (hasWhiteSpace.test(name)) {
        return false;
    }

    var validName = /^[$A-Z_][0-9A-Z_$]*$/i;
    return validName.test(name);
}