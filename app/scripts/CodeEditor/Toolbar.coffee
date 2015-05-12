module.exports =

  class Toolbar extends Backbone.View

    initialize: (opts) ->
      _.bindAll @, 'render'
      @render()

    events:
      'click .new-file': 'newFile'

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
          <div class="btn-group" role="group">
              <button type="button" class="btn btn-default btn-sm new-file" aria-label="Left Align">
                  <span class="glyphicon glyphicon-file" aria-hidden="true"></span>
              </button>
          </div>
          <!-- Single button -->
          <div class="btn-group pull-right" role="group">
            <button type="button" class="btn btn-default btn-sm dropdown-toggle" data-toggle="dropdown" aria-expanded="false">
              <span class="glyphicon glyphicon-menu-hamburger" aria-hidden="true"></span>
            </button>
            <ul class="dropdown-menu" role="menu">
              <li><a href="#"><span class="glyphicon glyphicon-align-left" aria-hidden="true"></span>&nbsp;&nbsp;Save</a></li>
            </ul>
          </div>
      </div>
      """
      $(@el).html html

    resize: ->
      #once it gets past a certain width, put them all in a list on the right.
      console.log(@$el.width())

    newFile: ->
      @parent().tabpanel.newTab()
