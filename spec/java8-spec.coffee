# This file contains all specs to ensure the fundamental functionality of
# this plugin in use with java 1.8.

_fs = require 'fs'
_path = require 'path'


_helpers = require _path.join(__dirname, '_spec-helpers.coffee')


describe 'linter-javac using java 1.8.0 u74', ->
  JavacLinter = null # generic reference to the Javac-Linter-instance
  currentFilePath = '' # introduce generic path for the targeted java-file
  texteditor = null # introduce a generic texteditor-reference

  describe 'when using a broken java-source file', ->
    # set the generic path for this test series
    currentFilePath = _path.join(__dirname, 'fixtures', 'BrokenWorld.java')

    beforeEach ->
      waitsForPromise ->
        atom.packages.activatePackage 'linter'
        atom.packages.activatePackage 'linter-javac'
      waitsForPromise ->
        atom.workspace.open(currentFilePath).then (editor) ->
          # set generic texteditor-reference
          texteditor = editor
          # set the reference to the javac-linter
          #Linter = require 'linter'
          JavacLinter = getProvider

    afterEach ->
      # close the active workspace-window to ensure a reload
      atom.workspace.close

    it 'should open the texteditor', ->
      expect(texteditor.getPath()).toBe(currentFilePath)

    it 'should not contain any linter-messages', ->
      expect(JavacLinter.getMessages().length).toBe(0)

    it 'should file all expected bugs after linting', ->
      texteditor.save
