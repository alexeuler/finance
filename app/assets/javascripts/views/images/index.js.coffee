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

    renderThumbs: ->
      #rendering thumbs
      thumbsContainer = $('.image-gallery .thumbs-container')
      for image, i in @collection.models
        thumbs_view = @thumbTemplate({
          id:image.get('id'),
          url:image.get('url_small')
        })
        thumbsContainer.append thumbs_view

      #handling events
      thumbsContainer.find(".image-thumb-container").on "click", (e) ->
        id = $(e.currentTarget).data('id')
        thumbsContainer.data('id', id)
        thumbsContainer.find(".image-thumb-container").removeClass('selected')
        $(e.currentTarget).addClass('selected')


    renderEditTags: ->
      controlPanel = $(".image-gallery .control-panel-container")
      #rendering edit_tags
      editTagsView = @editTagsTemplate()
      controlPanel.append editTagsView

      updateButton = controlPanel.find(".edit-tags-button")
      updateButton.on 'click', ->
        id=$('.image-gallery .thumbs-container').data('id')
        tags=controlPanel.find("#image_tags").val()
        csrfToken = $("meta[name=csrf-token]")[0].content
        console.log csrfToken
        $.ajax(
          type: 'patch'
          url: "/images/#{id}"
          data:
            csrf: csrfToken
            image:
              tags: tags
        )


    render: ->
      @$el.empty()
      @$el.append @template()

      @renderThumbs()
      @renderEditTags()
      controlPanel = $(".image-gallery .control-panel-container")
      #rendering tags
      tags = []
      for image, i in @collection.models
        image_tags=image.get('tags')
        if image_tags?
          for tag in image_tags
            tags << tag
      tagsView = @tagsTemplate tags:tags
      controlPanel.append tagsView


      #rendering upload_image
      uploadImageView = @uploadImageTemplate()
      controlPanel.append uploadImageView

      @
