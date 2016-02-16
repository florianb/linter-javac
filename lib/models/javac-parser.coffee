module.exports = (content) ->
  @writtenFiles = []
  @linterMessages = []

  errRegex = /^(.*\.java):(\d+): ([\w \-]+): (.+)/

  # This regex helps to estimate the column number based on the
  #   caret (^) location.
  # caretRegex = /^( *)\^/
  caretIndex = line.indexOf '^'
  # Split into lines
  lines = javacOutput.split /\r?\n/

  line.match errRegex
