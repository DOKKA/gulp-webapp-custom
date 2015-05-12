module.exports =

  class Toolbar extends Backbone.View

    initialize: (opts) ->
      _.bindAll @, 'render'
      @items = [[{
        name: 'Save',
        icon: 'floppy-disk',
      },{
        name: 'Save All',
        icon: 'floppy-saved',
      }],[{
        name: 'New File',
        icon: 'file',
        cls: 'new-file'
      }],[{
        name: 'Undo',
        icon: 'arrow-left',
      },{
        name: 'Redo',
        icon: 'arrow-right'
      }],[{
        name: 'Toggle Comment',
        icon: 'object-align-left'
      }],[{
        name: 'Toggle Autocomplete',
        icon: 'tasks'
      }],[{
        name: 'Cut',
        icon: 'scissors'
      },{
        name: 'Copy',
        icon: 'duplicate'
      },{
        name: 'Paste',
        icon: 'paste'
      }],[{
        name: 'Revert',
        icon: 'refresh'
      },{
        name: 'Close',
        icon: 'remove-circle'
      }]]
      @render()

    events:
      'click .new-file': 'newFile'

    render: ->
      #make both lists and hide one!

      html = """<div class="btn-toolbar" role="toolbar">"""
      for buttonGroup in @items
        html += """<div class="btn-group toolbar-button" role="group">"""
        for button in buttonGroup
          button.id = _.uniqueId('btn')
          html += """
            <button type="button" id="#{button.id}" title="#{button.name}"class="btn btn-default btn-sm #{button.cls || ''}" aria-label="Left Align">
              <span class="glyphicon glyphicon-#{button.icon}" aria-hidden="true"></span>
            </button>
          """
        html += """</div>"""

      html += """
        <div class="btn-group toolbar-list" role="group">
          <button type="button" class="btn btn-default btn-sm dropdown-toggle" data-toggle="dropdown" aria-expanded="false">
            <span class="glyphicon glyphicon-menu-hamburger" aria-hidden="true"></span>
          </button>
            <ul class="dropdown-menu" role="menu">
      """
      for buttonGroup in @items
        for button in buttonGroup
          html += """
            <li><a href="#"><span class="glyphicon glyphicon-#{button.icon}" aria-hidden="true">
            </span>&nbsp;&nbsp;#{button.name}</a></li>
          """
        html += """<li class="divider"></li>"""

      html += """</ul>"""
      html += """</div>"""

      html += """</div>"""

      $(@el).html html
      setTimeout(=>
        @resize()
      ,10)

    resize: ->
      width = @$el.width()
      if(width < 400 && width != 0)
        @$('.toolbar-list').show()
        @$('.toolbar-button').hide()
      else
        @$('.toolbar-list').hide()
        @$('.toolbar-button').show()

    newFile: ->
      @parent().tabpanel.newTab()



