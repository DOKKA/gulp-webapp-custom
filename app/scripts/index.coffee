CodeEditor = require './CodeEditor/CodeEditor'


panels = []


config = content: [{
  type: 'column'
  content: [
    {
      type: 'component'
      componentName: 'example'
      componentState: text: 'Component 1'
    }

  ]
}]

myLayout = new GoldenLayout(config, $('#main'))
myLayout.registerComponent 'example', (container, state) ->
  console.log 'new container'
  new CodeEditor({
    el: container.getElement()
    container: container,
    state: state
  })



resize = ->
  height = $(window).height()
  width = $(window).width()
  main = $('#main')
  main.css
    width: width
    height: height - 32



resize()
myLayout.init()
$(window).resize ->
  resize()
  setTimeout(->
    myLayout.updateSize()
    console.log 'resizing layout'
  ,100)

$('#navbar .active').click( ->
  tabpanel = $('.splitter-right').first()
  tab1 = _.uniqueId('tab')
  navtab = $('.nav-tabs',tabpanel)
  tabcontent = $('.tab-content', tabpanel)
  console.log navtab
  navtab1 = """
  <li role="presentation">
  <a href="##{tab1}" aria-controls="#{tab1}" role="tab" data-toggle="tab">#{tab1}.js</a>
  </li>
  """
  tabcontent1 = """<div role="tabpanel" class="tab-pane" id="#{tab1}" style="height: 100%; width: 100%"></div>"""
  navtab.append(navtab1)
  tabcontent.append(tabcontent1)
  #$('#'+tab1).css({height: '100%', width: '100%'})
  @editor = ace.edit(tab1)
  @editor.setTheme('ace/theme/monokai')
  @editor.getSession().setMode('ace/mode/javascript')
  @editor.setOptions({
    fontSize: "14px"
  });
)
