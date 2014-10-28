
describe 'THE DOM', ->

  it 'has a `window` object', ->
    expect(root.window).to.not.equal null

  it 'has a `document` object', ->
    expect(root.document).to.not.equal null

  it 'can create elements and add them to the DOM', ->
    element = root.document.createElement('div')
    root.document.body.appendChild element
    expect(root.document.children.length).to.equal 1

  # it 'has access to jQuery as `$`', ->


