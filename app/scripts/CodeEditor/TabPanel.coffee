EditorTab = require './EditorTab'

module.exports =

  class TabPanel extends Backbone.View

    initialize: (opts) ->
      _.bindAll @, 'render'
      @render()
      @tabs = []

    render: ->
      html= """
      <div role="tabpanel" style="height: 100%; width: 100%">
          <!-- Nav tabs -->
          <ul class="nav nav-tabs" role="tablist">

          </ul>

          <!-- Tab panes -->
          <div class="tab-content">

          </div>
      </div>
      """
      $(@el).html html
      setTimeout( =>
        height = $(@el).height()-30
        width = $(@el).width()-5
        $('.tab-content', @el).css({height: height, width: width})
        $('.nav-tabs', @el).sortable({
          #axis: 'x',
          delay: 150,
          helper: 'clone',
          appendTo: 'body',
          zIndex: 1000,
          connectWith: '.nav-tabs'
        })
      ,10)

    resize: ->
      height = $(@el).height()-30
      width = $(@el).width()
      $('.tab-content', @el).css({height: height, width: width})
      @tabs.forEach((tab) ->
        tab.editor.resize(true))

    newTab: ->
      tabId = _.uniqueId('tab')
      navTabContainer = @$('.nav-tabs')
      tabContainer = @$('.tab-content')
      navTabTemplate = """
        <li role="presentation">
        <a href="##{tabId}" aria-controls="#{tabId}" role="tab" data-toggle="tab">#{tabId}.js
        </a>
        </li>
      """
      tabContentTemplate = """
      <div role="tabpanel" class="tab-pane" id="#{tabId}" style="height: 100%; width: 100%"></div>
      """
      navTabContainer.append(navTabTemplate)
      tabContainer.append(tabContentTemplate)

      navtab = @$('.nav-tabs a:last')
      navtab.css({'padding-right': '25px'});

      tab = @$('#'+tabId)
      navtab.tab('show')
      editorTab = new EditorTab({el: tab, navtab: navtab})
      @tabs.push(editorTab)

      liNav = navtab.parent();
      closebtn = $('<span class="glyphicon glyphicon-remove-circle close-tab" aria-hidden="true"></span>').appendTo(liNav)

      closebtn.click =>
        liNav.remove()
        editorTab.editor.destroy()
        tab.remove()
        @$('.nav-tabs a:last').tab('show')

