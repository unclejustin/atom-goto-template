GotoTemplate = require '../lib/goto-template'

# Use the command `window:run-package-specs` (cmd-alt-ctrl-p) to run specs.
#
# To run a specific `it` or `describe` block add an `f` to the front (e.g. `fit`
# or `fdescribe`). Remove the `f` to unfocus the block.

describe "GotoTemplate", ->
  [workspaceElement, activationPromise] = []

  beforeEach ->
    workspaceElement = atom.views.getView(atom.workspace)
    activationPromise = atom.packages.activatePackage('goto-template')

  describe "when the goto-template:go event is triggered", ->
    it "attempts to open a file from the selected text", ->
      # This is an activation event, triggering it will cause the package to be
      # activated.
      atom.commands.dispatch workspaceElement, 'goto-template:go'

      waitsForPromise ->
        activationPromise

      runs ->
        expect(true).toBe(true)
