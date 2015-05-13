CodeEditor = require './CodeEditor/CodeEditor'


panels = []


config = content: [{
  type: 'column'
  content: [
    {
      type: 'component'
      componentName: 'example'
      componentState: text: 'Component 1'
    },{
      type: 'component'
      componentName: 'example'
      componentState: text: 'Component 1'
    },{
      type: 'component'
      componentName: 'example'
      componentState: text: 'Component 1'
    }
  ]
}]

myLayout = new GoldenLayout(config, $('#main'))
myLayout.registerComponent 'example', (container, state) ->
  console.log 'new container'
  panel = new CodeEditor({
    el: container.getElement(),
    container: container,
    state: state
  })
  panel.getPanels = -> panels
  panels.push(panel)
  container.on('destroy', ->
    panel.remove()
    panels = _.without(panels, panel))


resize = ->
  height = $(window).height()
  width = $(window).width()
  main = $('#main')
  main.css
    width: width
    height: height - 62



resize()
myLayout.init()

$(window).resize ->
  resize()
  setTimeout(->
    myLayout.updateSize()
    console.log 'resizing layout'
  ,10)
