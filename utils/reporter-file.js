
var mocha = require('mocha'),
    // Cobertura = require('mocha-cobertura-reporter'),
    fs = require('fs'),
    // js2xml = require('js2xmlparser'),

    // config = require('../config'),
    config = {
        "reporter" : "Spec",
        "file"     : "xunit.xml"
    },

    Base = mocha.reporters.Base,

    reporterName = process.env.MOCHA_REPORTER || config.reporter || 'XUnit',
    Reporter = /*reporterName === 'Cobertura' ? Cobertura :*/ mocha.reporters[reporterName],
    filePath = process.env.MOCHA_REPORTER_FILE || config.file || process.cwd() + "/xunit.xml";

function ReporterFile(runner) {

    // Hijack stdout.write() before calling the Reporter
    // This will override mocha's internal calls to process.stdout.write() so
    // that it uses fs.writeFile() instead, allowing us to make Mocha write to
    // the file we set as MOCHA_REPORTER_FILE
    var unhookStdout = require('./intercept-stdout.js')(function intercept(string){
        fs.writeFile(filePath, string);
    });

    Reporter.call(this, runner);

    var stats = this.stats,
        tests = [];

    runner.on('test', function(test){
        tests.push(test);
    });

    runner.on('end', function(){
        // Release process.stdout.write() so that any more calls to it in the
        // current process work normally again
        unhookStdout();
        // See how this console.log outputs back to the terminal
        console.log('> Report was written to: ' + filePath + '\n');
    });
}

// Inherit from the specified reporter
ReporterFile.prototype = Reporter.prototype;


module.exports = ReporterFile;
