module.exports =

  class TabPanel extends Backbone.View

    initialize: (opts) ->
      _.bindAll @, 'render'
      @render()

    render: ->
      tab1 =  _.uniqueId()
      tab2 =  _.uniqueId()
      tab3 =  _.uniqueId()
      html= """
      <div role="tabpanel">
          <!-- Nav tabs , this is all broken -->
          <ul class="nav nav-tabs" role="tablist">
              <li role="presentation" class="active"><a href="#home" aria-controls="home" role="tab" data-toggle="tab">Home</a></li>
              <li role="presentation"><a href="#profile" aria-controls="profile" role="tab" data-toggle="tab">Profile</a></li>
              <li role="presentation"><a href="#messages" aria-controls="messages" role="tab" data-toggle="tab">Messages</a></li>
              <li role="presentation"><a href="#settings" aria-controls="settings" role="tab" data-toggle="tab">Foo</a></li>
          </ul>

          <!-- Tab panes -->
          <div class="tab-content">
              <div role="tabpanel" class="tab-pane active" id="home">
                  <p>Home Content</p>
              </div>
              <div role="tabpanel" class="tab-pane" id="profile">...</div>
              <div role="tabpanel" class="tab-pane" id="messages">...</div>
              <div role="tabpanel" class="tab-pane" id="settings">...</div>
          </div>
      </div>
      """
      $(@el).append html
