# Register with coffee coverage
require("coffee-coverage").register
  path     : "relative"
  basePath : __dirname + "/../src"

root.jsdom = require 'jsdom'
root.sinon = require 'sinon'

# Setup Chai, append the should() syntax to Object.prototype, and use sinon
root.chai = require 'chai'
root.expect = root.chai.expect
chai.use require 'sinon-chai'
root.chai.should()

root.sandbox = null

# Create a DOM to test client side scripts
root.document = jsdom.jsdom '<html><head></head><body></body></html>'
root.window = document.parentWindow
root.navigator = root.window.navigator
root.window.XDomainRequest = undefined

# TODO: Can we point this to vendor?
root.$ = root.jQuery = require 'jquery'

beforeEach ->
  root.sandbox = sinon.sandbox.create()

afterEach ->
  root.sandbox.restore()
