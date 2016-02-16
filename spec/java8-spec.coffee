# This file contains all specs to ensure the fundamental functionality of
# this plugin in use with java 1.8.

_path = require 'path'


_helpers = require _path.join(__dirname, '_spec-helpers.coffee')

describe 'linter-javac', ->
  describe 'provideLinter()', ->
    beforeEach ->
      # get linter-module
      linterJavac = require(
        _path.join(__dirname, '..', 'lib', 'init.coffee')
      )

      # inject javaExecutablePath
      linterJavac.javaExecutablePath = 'javac'

      linterJavac.helpers = { exec: () ->
        console.info 'ping.'
      }

      # instantiate linter-worker
      @linter = linterJavac.provideLinter()

      # stab texteditor, to assure stubbing
      @texteditor = null

    describe 'when using a broken java-source file', ->
      beforeEach ->
        # set proper texteditor-path to the faulty fixture
        @texteditor = _helpers.texteditorFactory(
          _path.join(__dirname, 'fixtures', 'broken-world.java')
        )

      it 'returns at least 8 messages in the linter-message-object', ->
        waitsForPromise( =>
          @linter.lint(@texteditor).then( (messages) ->
            expect(messages.length).toBeGreaterThan(7)
          )
        )
