module.exports =

  class TabPanel extends Backbone.View

    initialize: (opts) ->
      _.bindAll @, 'render'
      @render()

    render: ->
      tab1 = _.uniqueId('tab')
      tab2 = _.uniqueId('tab')
      html= """
      <div role="tabpanel">
          <!-- Nav tabs , this is all broken -->
          <ul class="nav nav-tabs" role="tablist">
              <li role="presentation" class="active"><a href="##{tab1}" aria-controls="#{tab1}" role="tab" data-toggle="tab">Home</a></li>
              <li role="presentation"><a href="##{tab2}" aria-controls="#{tab2}" role="tab" data-toggle="tab">Profile</a></li>
          </ul>

          <!-- Tab panes -->
          <div class="tab-content">
              <div role="tabpanel" class="tab-pane active" id="#{tab1}">
                  <p>Home Content</p>
              </div>
              <div role="tabpanel" class="tab-pane" id="#{tab2}">...</div>
          </div>
      </div>
      """
      $(@el).append html
