{CompositeDisposable} = require 'atom'

module.exports =
  subscriptions: null

  activate: ->
    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'goto-template:go': => @go()
    @subscriptions.add atom.commands.add 'atom-workspace', 'goto-template:gotest': => @gotest()

  deactivate: ->
    @subscriptions.dispose()

  go: ->
    if editor = atom.workspace.getActiveTextEditor()
      editorElement = atom.views.getView(editor)
      atom.commands.dispatch(editorElement, 'expand-selection-to-quotes:toggle')
      path = editor.getSelectedText()
      console.log(path)
      atom.workspace.open(path)

  gotest: ->
    if editor = atom.workspace.getActivePaneItem()
      file = editor?.buffer.file
      if (path.extname file?.path) is '.ts'
        filePath = file?.path.replace('/src/', '/test/')
        filePath = filePath.replace('.ts', '.spec.js')
        atom.project.relativizePath(filePath)
        console.log(filePath)
        atom.workspace.open(filePath)
