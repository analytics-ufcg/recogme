  
var Key = function (){
        var keyCode, keyValue, keyDown, keyUp;
    }

function keystrokeOnField(field, timestamps) {
        
        onKeyDown(field, timestamps);
    }


function onKeyDown(field, timestamps){
        $( '#' + field ).keydown(function( event ) {
        
        key = new Key;
        key.keyCode = event.keyCode;
        key.keyValue = String.fromCharCode(event.keyCode); //get the Char value for a keycode.

        key.keyDown = event.timeStamp;
        onKeyUp(field, timestamps, key); // keyup listener
        
        //console.log(timestamps);
        });
    }

function onKeyUp(field, timestamps, k) {
        $( '#' + field ).keyup(function( event ) {
            if(k.keyCode === event.keyCode){ //check if the keyup event is for the right key
                if (k.keyUp === undefined) {
 var jsonFields = JSON.stringify(fields);
                       k.keyUp = event.timeStamp;
                    k = keyValueCheck(k); //check if the keyValue is empty.

                    timestamps.push(k);
                    console.log(k);
                }
            }
        });
     }


     //check if the keyValue is empty. Return the key object
     function keyValueCheck (k) {
        if(keycodes[k.keyCode]){
            k.keyValue = keycodes[k.keyCode];
        }
        return k;
     }

//defines an object for the fields in the form. 
fields = {'fullName': [], 
          'confirmFullName': [],
          'email': [], 
          'confirmEmail': [], 
          'password': [], 
          'confirmPassword': [],
          'userText': []
      }

//applying the keystroke listener for each field in the form.
for (var field in fields) {
    keystrokeOnField(field, fields[field]);
}


// $('#btnclick').click(function (event) {    
//     var jsonFields = JSON.stringify(fields);
//     console.log(jsonFields);
//     console.log(fields);
// });

//Check the id for the submit button in Django project.
$('form').submit(function (event) {    
    var jsonFields = JSON.stringify(fields);
    $('.registro').append('<div class="form-group"><input type="text" id="keystroke" name="keystroke" class="form-control" ></div>'); //add input box

    $('#keystroke').val(jsonFields);
    console.log(jsonFields);
});