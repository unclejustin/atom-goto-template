{CompositeDisposable} = require 'atom'

module.exports =
  subscriptions: null

  activate: ->
    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'goto-template:go': => @go()

  deactivate: ->
    @subscriptions.dispose()

  go: ->
    if editor = atom.workspace.getActiveTextEditor()
      path = editor.getSelectedText()
      atom.workspace.open(path)
