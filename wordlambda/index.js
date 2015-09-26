console.log('Loading function');

var exec = require('child_process').exec;

exports.handler = function(event, context) {
 
 exec('echo '+ event.key1 + '| sh ./wordFreq.sh', function(error, stdout) {
        context.done(error, stdout);
    });

};
