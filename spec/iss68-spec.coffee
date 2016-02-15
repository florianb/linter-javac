# this file contains specs to rebuild the following issue:
# https://github.com/AtomLinter/linter-javac/issues/68

_path = require 'path'


describe 'atom workspace opening a raw java-file', ->
  fixturePath = _path.join(__dirname, 'fixtures', 'BrokenWorld.java')

  beforeEach ->
    waitsForPromise ->
      atom.workspace.open(fixturePath)

  it "should be opened in an editor", ->
    expect(atom.workspace.getActiveTextEditor()
      .getPath())
        .toContain 'BrokenWorld.java'

  it 'should lint without exception', ->
    expect(atom.workspace.getActiveTextEditor()
      .getPath())
        .toContain 'BrokenWorld.java'
