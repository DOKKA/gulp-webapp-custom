module.exports =

  class EditorTab extends Backbone.View

    initialize: (opts) ->
      _.bindAll @, 'render'
      @render()

    render: ->
      zzz = _.uniqueId()
      html= """
      <div>
      </div>
      """
      $(@el).append html

