TabPanel = require './TabPanel'
TreePanel = require './TreePanel'
Toolbar = require './Toolbar'


module.exports =

  class CodeEditor extends Backbone.View

    initialize: (opts) ->
      @state = opts.state
      @container = opts.container
      _.bindAll @, 'render'
      @render()

    render: ->
      zzz = _.uniqueId()
      html = """
    <div class="panel panel-default">
        <div class="panel-heading">

        </div>
        <div class="splitter">
            <div class="splitter-left">


            </div>
            <div class="splitter-right">

            </div>
        </div>
    </div>
    """
      $(@el).html html
      setTimeout(=>
        height = $(@el).height()-45
        width = $(@el).width()
        $('.panel', @el).css({height: height, width: width})
        splitter = $('.splitter',@el).jqxSplitter({
          orientation: 'vertical',
          width: '100%'
          height: '100%'
          panels: [{size: '200px'}]
        });
        splitter.on('resize', =>
          if(@tabpanel)
            @tabpanel.resize())
        @container.on('resize', =>
          height = $(@el).height()-45
          width = $(@el).width()
          $('.panel', @el).css({height: height, width: width})
          $('.splitter', @el).jqxSplitter('render')
          if(@tabpanel)
            @tabpanel.resize())
        @toolbar = new Toolbar({el: $('.panel-heading',@el) })
        @toolbar.parent = () =>
          return @

        @tabpanel = new TabPanel({el: $('.splitter-right',@el) })
        @tabpanel.parent = () =>
          return @

        @treepanel = new TreePanel({el: $('.splitter-left',@el) })
        @treepanel.parent = () =>
          return @

        @tabpanel.newTab()
      ,10)


