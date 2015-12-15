

var app = angular.module('cadastro', [
  'jcs-autoValidate',
	'angular-ladda',
	'validation.match'
]);

app.run(function (defaultErrorMessageResolver) {
		defaultErrorMessageResolver.getErrorMessages().then(function (errorMessages) {
				
			errorMessages['invalidField'] = 'Invalid Field.';
			errorMessages['emptyField'] = 'Fill the field below.';
			errorMessages['invalidEmail'] = 'Invalid Email';
			errorMessages['emailMatchErr'] = "Emails Don't Match";
			errorMessages['nameMatchErr'] = "Names Don't Match";
			errorMessages['invalidPassword'] = 'Invalid Password. Password must have at least 10 digits and contain letters and numbers';
			errorMessages['passwordMatchErr'] = "Passwords Don't Match.";
			errorMessages['textMatchErr'] = "Text Don't Match";
			errorMessages['loginMatchErr'] = "User Login Don't Match";

		});
	}
);

app.controller('CadastroCtrl', function ($scope, $http) {
	$scope.formModel = {};
	$scope.submitting = false;
	$scope.submitted = false;
	$scope.has_error = false;


	$scope.textField = $('#textField').text();

	
});

// app.controller('getRandomTextCtrl', ['$scope', '$http', function($scope, $http) {
//     	$http.get('data.json').success(function(data) {
// 		$scope.datajson = data;
// 		$scope.whichItem = 0;
// 		$scope.randomText = data[0];	
// 	});
// }]);
