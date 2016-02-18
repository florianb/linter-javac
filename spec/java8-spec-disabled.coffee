# This file contains all specs to ensure the fundamental functionality of
# this plugin in use with java 1.8.

_fs = require 'fs'
_path = require 'path'


_helpers = require _path.join(__dirname, '_spec-helpers.coffee')


_linter = require _path.join(__dirname, '..', 'lib', 'init.coffee')


describe 'linter-javac using java 1.8.0 u74', ->
  currentFilePath = '' # general reference to the current java-file
  texteditor = null # general reference to the texteditor
  linter = null # general reference to the current linter

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
          linter = _linter.provideLinter()

    it 'should open the texteditor', ->
      expect(texteditor.getPath()).toBe(currentFilePath)

    it 'should file all expected bugs after linting', ->
      waitsForPromise ->
        linter.lint(texteditor).then (result) ->
          expect(result.length).toBe(9)
