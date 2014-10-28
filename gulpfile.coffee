gulp = require 'gulp'
mocha = require 'gulp-mocha'

gulp.task 'mocha', (done) ->
  gulp.src(['test/spec_init.coffee','test/**/*_spec.coffee'], {read: no})
  .pipe(mocha(
    compilers: 'coffee:coffee-script/register'
    reporter: 'spec'
  ))

