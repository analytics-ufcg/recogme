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
			errorMessages['loginMatchErr'] = 'Login não confere.';
		});
	}
);

app.controller('CadastroCtrl', function ($scope, $http) {
	$scope.formModel = {};
	$scope.submitting = false;
	$scope.submitted = false;
	$scope.has_error = false;

	$scope.textField = $('#textField').text();

	console.log("sdfasdfasdfsadfsda");

	$scope.onSubmit = function () {
		$scope.submitting = true;
		console.log("Hey i'm submitted!");
		console.log($scope.formModel);
	};
});

app.controller('getRandomTextCtrl', ['$scope', '$http', function($scope, $http) {
    	$http.get('data.json').success(function(data) {
		$scope.datajson = data;
		$scope.whichItem = 0;
		$scope.randomText = data[0];
	});
}]);

