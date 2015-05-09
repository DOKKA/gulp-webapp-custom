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
        <a href="##{tabId}" aria-controls="#{tabId}" role="tab" data-toggle="tab">#{tabId}.js</a>
        </li>
      """
      tabContentTemplate = """
      <div role="tabpanel" class="tab-pane" id="#{tabId}" style="height: 100%; width: 100%"></div>
      """
      navTabContainer.append(navTabTemplate)
      tabContainer.append(tabContentTemplate)

      navtab = @$('.nav-tabs a:last')
      tab = @$('#'+tabId)
      navtab.tab('show')
      @tabs.push(new EditorTab({el: tab, navtab: navtab}))


