# This is me trying to understand mocha and make it obey me

## This Will include
+ Setting up `mocha` (:YES)
+ Using `chai` and `should` (:YES)
+ Adding a DOM to test client-side code with `jsdom` (:YES)
+ The ability to test jQuery code and general DOM manipulation (:YES)
+ Make jQuery load the same way its set up in the hub project
+ Unit testing coffeescript files and generating coverage reports with `coffee-coverage` (:YES)
+ The ability to run everything with a simple `gulp` task

See [here](http://code.tutsplus.com/tutorials/better-coffeescript-testing-with-mocha--net-24696) for the starting point.

## Commands

### Mocha

#### Reporting directly to console
`mocha --compilers coffee:coffee-script/register -R spec test/spec_init.coffee test`

#### With an HTML report
`mocha --compilers coffee:coffee-script/register -R html-cov test/spec_init.coffee test > coverage/coverage.html`


