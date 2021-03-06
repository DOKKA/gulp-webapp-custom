module.exports =

  class EditorTab extends Backbone.View

    initialize: (opts) ->
      @navtab = opts.navtab
      _.bindAll @, 'render'
      @render()

    render: ->
      @editor = ace.edit(@el)
      @editor.setTheme('ace/theme/monokai')
      @editor.getSession().setMode('ace/mode/javascript')
      @editor.setOptions({
        fontSize: "14px"
      });
