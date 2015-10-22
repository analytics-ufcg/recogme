
    var Key = function (){
        var keyPressed, keyDown, keyUp;
    }

    
    function keystrokeOnField(field, timestamps) {
        
        onKeyDown(field, timestamps);
    }


    function onKeyDown(field, timestamps){
        $( '#' + field ).keydown(function( event ) {
        
        key = new Key;
        key.keyCode = event.keyCode;
        key.keyValue = String.fromCharCode(event.keyCode);

        key.keyDown = event.timeStamp;
        onKeyUp(field, timestamps, key);
        
        console.log(timestamps);
        });
    }
    
    function onKeyUp(field, timestamps, k) {
        $( '#' + field ).keyup(function( event ) {
            if(k.keyCode === event.keyCode){
                if (k.keyUp === undefined) {
                    k.keyUp = event.timeStamp;
                     
                     k = keyValueCheck(k); //check if the keyValue is empty.

                    timestamps.push(k);
                }
            }
        });
     }


     function keyValueCheck (k) {
        if(keycodes[k.keyCode]){
            k.keyValue = keycodes[k.keyCode];
        }
        return k;
     }


fields = {'fullName': [], 
          'confirmFullName': [],
          'email': [], 
          'confirmEmail': [], 
          'password': [], 
          'confirmPassword': [], 
          'userText': []
      }

for (var field in fields) {

    keystrokeOnField(field, fields[field]);
}


$('#btnclick').click(function (event) {    
    var jsonFields = JSON.stringify(fields);
    console.log(jsonFields);
});

//Check the id for the submit button in Django project.
$('#btnSubmit').submit(function (event) {    
    var jsonFields = JSON.stringify(fields);
    console.log(jsonFields);
});