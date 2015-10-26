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
          key.keyValue = String.fromCharCode(event.keyCode); //get the Char value for the keycode.

          key.keyDown = event.timeStamp;
          onKeyUp(field, timestamps, key); // keyup listener

    });
}

function onKeyUp(field, timestamps, k) {
     $( '#' + field ).keyup(function( event ) {
            //check if the keyup event is for the right key
          if(k.keyCode === event.keyCode){

              //assure if the keyup value for the right key is not defined already
                if (k.keyUp === undefined) {
                    k.keyUp = event.timeStamp;

                     k = keyValueCheck(k); //check if the keyValue is empty.
                    timestamps.push(k);
                    
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

//defines an object for the fields in the form. Return the IDs for the form fields.
var fieldNames = function () {
    var formFields = $("input").not("#PreventAutocomplete"); // get the input fields.
    //var userText = $("textArea")[0].id; //get the id for the text Area
    var fieldIDs = {};

    //fieldIDs[userText] = []; // add the userText id.

    for (var i = 0; i < formFields.length; i++) {

      var fieldID = formFields[i].id;

      fieldIDs[fieldID] = [];
    };
    return fieldIDs;
}

var fields = fieldNames();

//applying the keystroke listener for each field in the form.
for (var field in fields) {
    keystrokeOnField(field, fields[field]);
}

//Check the id for the submit button in Django project.
$('form').submit(function (event) {    
    var jsonFields = JSON.stringify(fields);
    $('.registro').append('<div class="form-group"><input type="text" id="keystroke" name="keystroke" class="form-control" ></div>'); //add input box

    $('#keystroke').val(jsonFields);
    console.log(jsonFields);
});