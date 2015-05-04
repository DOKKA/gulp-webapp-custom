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
    $(@el).append html
    that = @
    splitter = $('.splitter',@el).jqxSplitter({
      orientation: 'vertical',
      panels: [{size: '200px'}]
    });
    that.container.on('resize', ->
      height = $(that.el).height()-45
      width = $(that.el).width()
      $('.splitter', that.el).css({height: height, width: width})

      $('.splitter', that.el).jqxSplitter('expand');
      #splitter.refresh();
      #$('.splitter-left',@el).resizable();
      #splitter.resize()
    )
    #splitter.resize()
    @toolbar = new Toolbar({el: $('.panel-heading',@el) })
    @tabpanel = new TabPanel({el: $('.splitter-right',@el) })
    @treepanel = new TreePanel({el: $('.splitter-left',@el) })

