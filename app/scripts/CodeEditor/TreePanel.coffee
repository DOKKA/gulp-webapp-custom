module.exports =

  class TreePanel extends Backbone.View

    initialize: (opts) ->
      _.bindAll @, 'render'
      @render()

    render: ->
      zzz = _.uniqueId()
      html= """
      <nav class="navbar navbar-default">
          <div class="container-fluid">
              <ul class="nav navbar-nav">

                  <li class="dropdown">
                      <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">Public <span class="caret"></span></a>
                      <ul class="dropdown-menu" role="menu">
                          <li><a href="#">CODEMONSTER</a></li>
                          <li><a href="#">CODEZILLA</a></li>
                          <li><a href="#">GraphIDE</a></li>
                      </ul>
                  </li>
              </ul>
              <ul class="nav navbar-nav navbar-right">
                  <li>
                      <button type="button" class="navbar-btn btn btn-xs"><span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span></button>
                  </li>
              </ul>
          </div>
      </nav>
      <div class="jstree">
        <ul>
          <li>Root node
            <ul>
              <li>Child node 1</li>
              <li>Child node 2</li>
            </ul>
          </li>
        </ul>
      </div>
      """
      $(@el).html html
      $('.jstree', @el).jstree(
        core:
          themes:
            name: 'default-dark',
            dots: true,
            icons: true
      );

