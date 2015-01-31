NuclearView = require './nuclear-view'
{CompositeDisposable} = require 'atom'

module.exports = Nuclear =
  nuclearView: null
  modalPanel: null
  subscriptions: null

  activate: (state) ->
    @nuclearView = new NuclearView(state.nuclearViewState)
    @modalPanel = atom.workspace.addModalPanel(item: @nuclearView.getElement(), visible: false)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'nuclear:toggle': => @toggle()

  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @nuclearView.destroy()

  serialize: ->
    nuclearViewState: @nuclearView.serialize()

  toggle: ->
    console.log 'Nuclear was toggled!'

    if @modalPanel.isVisible()
      @modalPanel.hide()
    else
      @modalPanel.show()
