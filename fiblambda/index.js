console.log('Loading function');

var exec = require('child_process').exec;

exports.handler = function(event, context) {
 
 exec('./FastFib '+ event.key1 , function(error, stdout) {
        context.done(error, stdout);
    });

};
