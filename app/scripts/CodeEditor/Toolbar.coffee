module.exports =

  class Toolbar extends Backbone.View

    initialize: (opts) ->
      _.bindAll @, 'render'
      @render()

    render: ->
      zzz = _.uniqueId()
      html= """
      <div class="btn-toolbar" role="toolbar">
          <div class="btn-group" role="group">
              <button type="button" class="btn btn-default btn-sm" aria-label="Left Align">
                  <span class="glyphicon glyphicon-align-left" aria-hidden="true"></span>
              </button>
              <button type="button" class="btn btn-default btn-sm" aria-label="Left Align">
                  <span class="glyphicon glyphicon-align-left" aria-hidden="true"></span>
              </button>
              <button type="button" class="btn btn-default btn-sm" aria-label="Left Align">
                  <span class="glyphicon glyphicon-align-left" aria-hidden="true"></span>
              </button>
          </div>
          <div class="btn-group" role="group">
              <button type="button" class="btn btn-default btn-sm" aria-label="Left Align">
                  <span class="glyphicon glyphicon-align-left" aria-hidden="true"></span>
              </button>
              <button type="button" class="btn btn-default btn-sm" aria-label="Left Align">
                  <span class="glyphicon glyphicon-align-left" aria-hidden="true"></span>
              </button>
              <button type="button" class="btn btn-default btn-sm" aria-label="Left Align">
                  <span class="glyphicon glyphicon-align-left" aria-hidden="true"></span>
              </button>
          </div>
          <div class="btn-group" role="group">
              <button type="button" class="btn btn-default btn-sm" aria-label="Left Align">
                  <span class="glyphicon glyphicon-align-left" aria-hidden="true"></span>
              </button>
              <button type="button" class="btn btn-default btn-sm" aria-label="Left Align">
                  <span class="glyphicon glyphicon-align-left" aria-hidden="true"></span>
              </button>
              <button type="button" class="btn btn-default btn-sm" aria-label="Left Align">
                  <span class="glyphicon glyphicon-align-left" aria-hidden="true"></span>
              </button>
          </div>
      </div>
      """
      $(@el).append html