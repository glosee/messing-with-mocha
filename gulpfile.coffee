gulp = require 'gulp'
mocha = require 'gulp-mocha'
env = require 'gulp-env'
cobertura = require 'mocha-cobertura-reporter'
shell = require 'gulp-shell'

gulp.task 'mocha', ['set-env-vars'], (done) ->

  # Require reporter-file here, now that the env vars have been added
  reporterFile = require 'reporter-file'

  gulp.src(['test/spec_init.coffee','test/**/*_spec.coffee'], {read: no})
  .pipe(mocha(
    compilers: 'coffee:coffee-script/register'
    reporter: reporterFile
  ))

gulp.task 'set-env-vars', (done) ->
  env(
    vars:
      # Env vars needed for repoter-file to properly direct traffic
      MOCHA_REPORTER: 'HTMLCov'
      MOCHA_REPORTER_FILE: 'coverage/coverage.html'
  )

  done()

gulp.task 'manual-mocha', ['set-env-vars'], (done) ->

  gulp.src(['test/spec_init.coffee','test/**/*_spec.coffee'], {read: no})
  .pipe(shell([
    'mocha --compilers coffee:coffee-script/register --reporter mocha-cobertura-reporter > coverage/coverage.html'
  ]))

