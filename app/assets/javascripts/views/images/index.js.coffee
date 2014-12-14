App.namespace 'App.Views.Images', (ns)->
  class ns.Index extends Backbone.View

    tagName:'div'
    className:'images-container'

    thumbTemplate:JST['templates/images/thumb']
    controlPanelTemplate:JST['templates/images/control_panel']
    tagsTemplate:JST['templates/images/tags']
    editTagsTemplate:JST['templates/images/edit_tags']
    uploadImageTemplate:JST['templates/images/upload_image']
    template:JST['templates/images/index']

    initialize: ->
      _.bindAll @, 'render'
      @listenTo(@collection, 'sync', @render)
      @render()

    render: ->
      @$el.empty()
      @$el.append @template()
      thumbsContainer = $('.image-gallery .thumbs-container')
      for image, i in @collection.models
        ht = @thumbTemplate({
          id:image.get('id'),
          url:image.get('url_small')
        })
        thumbsContainer.append ht
      @
