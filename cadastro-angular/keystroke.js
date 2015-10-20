    var timestamps = [];

    
    var Key = function (){
        var keyPressed, keyDown, keyUp;
    }
    
    $( "#formField" ).keydown(function( event ) {
        
        key = new Key;
        key.keyCode = event.keyCode;
        key.keyValue = String.fromCharCode(event.keyCode);

        key.keyDown = event.timeStamp;
        onKeyUp(key);
        console.log(timestamps);
    });
    
    function onKeyUp(k) {
        $( "#formField" ).keyup(function( event ) {
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

    $("#clear").click(function (event) {
        console.clear();
    });

    $("#to_csv").click(function (event) {
        downloadCSV({ filename: "timestamps-data.csv" });
    });

function convertArrayOfObjectsToCSV(args) {  
        var result, ctr, keys, columnDelimiter, lineDelimiter, data;

        data = args.data || null;
        if (data == null || !data.length) {
            return null;
        }

        columnDelimiter = args.columnDelimiter || ',';
        lineDelimiter = args.lineDelimiter || '\n';

        keys = Object.keys(data[0]);

        result = '';
        result += keys.join(columnDelimiter);
        result += lineDelimiter;

        data.forEach(function(item) {
            ctr = 0;
            keys.forEach(function(key) {
                if (ctr > 0) result += columnDelimiter;

                result += item[key];
                ctr++;
            });
            result += lineDelimiter;
        });

        return result;
}

function downloadCSV(args) {  
        var data, filename, link;
        var csv = convertArrayOfObjectsToCSV({
            data: timestamps
        });
        if (csv == null) return;

        filename = args.filename || 'export.csv';

        if (!csv.match(/^data:text\/csv/i)) {
            csv = 'data:text/csv;charset=utf-8,' + csv;
        }
        data = encodeURI(csv);

        link = document.createElement('a');
        link.setAttribute('href', data);
        link.setAttribute('download', filename);
        link.click();
    }