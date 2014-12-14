App.namespace 'App.Views.Images', (ns)->
  class ns.Index extends Backbone.View

    tagName:'div'
    className:'images-container'

    initialize: ->
      _.bindAll @, 'render'
      @listenTo(@collection, 'sync', @render)
      @render()

    render: ->
      @$el.empty()
      for image, i in @collection.models
        @$el.append $("<div>#{image.get('access_token')}</div>")
      @
