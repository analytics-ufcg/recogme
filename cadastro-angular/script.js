var app = angular.module('cadastro', [
	'jcs-autoValidate',
	'angular-ladda',
	'validation.match'
]);

app.run(function (defaultErrorMessageResolver) {
		defaultErrorMessageResolver.getErrorMessages().then(function (errorMessages) {
			errorMessages['invalidField'] = 'Campo inválido.';
			errorMessages['emptyField'] = 'Preencha o campo acima.';
			errorMessages['invalidEmail'] = 'Email inválido.';
			errorMessages['emailMatchErr'] = 'Email não confere.';
			errorMessages['nameMatchErr'] = 'Nome não confere.';
			errorMessages['invalidPassword'] = 'Senha inválida. A senha deve conter no mínimo 10 digitos e ser formada por letras e/ou números.';
			errorMessages['passwordMatchErr'] = 'Senha nao confere.'
			errorMessages['textMatchErr'] = 'Texto nao confere.'
		});
	}
);

app.controller('CadastroCtrl', function ($scope, $http) {
	$scope.formModel = {};
	$scope.submitting = false;
	$scope.submitted = false;
	$scope.has_error = false;



	$scope.onSubmit = function () {
		$scope.submitting = true;
		console.log("Hey i'm submitted!");
		console.log($scope.formModel);
	};
});

app.controller('getRandomText', ['$scope', '$http', function($scope, $http) {
    	$http.get('data.json').success(function(data) {
		$scope.datajson = data;
		$scope.whichItem = 0;
		$scope.randomText = data[0];
	});
}]);

app.controller('textMatch', function ($scope) {
	var text = $('#randomText').text()
	var inputText = $('#userText').val()

	if (text === inputText){
		console.log("They match");
	}
});

