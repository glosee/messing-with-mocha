# This is me trying to understand mocha and make it obey me

## This Will include
+ Setting up `mocha`
+ Using `chai` and `should`
+ Adding a DOM to test client-side code with `jsdom`
+ The ability to test jQuery code and general DOM manipulation
+ Unit testing coffeescript files and generating coverage reports with `coffee-coverage`
+ The ability to run everything with a simple `gulp` task

See [here](http://code.tutsplus.com/tutorials/better-coffeescript-testing-with-mocha--net-24696) for the starting point.

For right now you have to use `mocha --compilers coffee:coffee-script/register -R spec test/spec_init.coffee test` in your command line to run the tests. Ideally all that config will be kept in the Gulp task.

