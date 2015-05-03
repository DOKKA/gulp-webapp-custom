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
    splitter = $('.splitter',@el).kendoSplitter({
      orientation: 'horizontal',
      panes: [
        { collapsible: true, size: "200px" },
        { collapsible: false}
      ]
    })
    that.container.on('resize', ->
      splitter.css({height: $(that.el).height()-42})
      splitter.resize()
    )
    splitter.resize()
    @toolbar = new Toolbar({el: $('.panel-heading',@el) })
    @tabpanel = new TabPanel({el: $('.splitter-right',@el) })
    @treepanel = new TreePanel({el: $('.splitter-left',@el) })

