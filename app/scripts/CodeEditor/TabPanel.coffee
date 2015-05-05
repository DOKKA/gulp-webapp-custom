module.exports =

  class TabPanel extends Backbone.View

    initialize: (opts) ->
      _.bindAll @, 'render'
      @render()

    render: ->
      tab1 = _.uniqueId('tab')
      tab2 = _.uniqueId('tab')
      html= """
      <div role="tabpanel" style="height: 100%; width: 100%">
          <!-- Nav tabs , this is all broken -->
          <ul class="nav nav-tabs" role="tablist">
              <li role="presentation" class="active"><a href="##{tab1}" aria-controls="#{tab1}" role="tab" data-toggle="tab">Something.js</a></li>
              <li role="presentation"><a href="##{tab2}" aria-controls="#{tab2}" role="tab" data-toggle="tab">Profile</a></li>
          </ul>

          <!-- Tab panes -->
          <div class="tab-content">
              <div role="tabpanel" class="tab-pane active" id="#{tab1}"></div>
              <div role="tabpanel" class="tab-pane" id="#{tab2}">...</div>
          </div>
      </div>
      """
      $(@el).append html
      setTimeout( =>
        height = $(@el).height()-30
        width = $(@el).width()-5
        $('.tab-content', @el).css({height: height, width: width})
        $('#'+tab1).css({height: '100%', width: '100%'})
        @editor = ace.edit(tab1)
        @editor.setTheme('ace/theme/monokai')
        @editor.getSession().setMode('ace/mode/javascript')
        @editor.setOptions({
          fontSize: "14px"
        });
      ,10)
    resize: ->
      height = $(@el).height()-30
      width = $(@el).width()
      $('.tab-content', @el).css({height: height, width: width})
      @editor.resize(true)
