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
      _.bindAll @, 'render', 'renderThumbs', 'renderTags',
        'renderEditTags', 'renderUploadImage'
      @listenTo(@collection, 'sync', @render)
      @render()

    renderThumbs: ->
      #rendering thumbs
      thumbsContainer = $('.image-gallery .thumbs-container')
      thumbsContainer.empty()
      for image, i in @collection.models
        #if tags string contains @tag
        if not @tag? or image.get('tags')?.indexOf(@tag) > -1
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
      updateButton.on 'click', =>
        id=$('.image-gallery .thumbs-container').data('id')
        tags=controlPanel.find("#image_tags").val()
        csrfToken = $("meta[name=csrf-token]")[0].content
        $.ajax(
          type: 'patch'
          url: "/images/#{id}"
          data:
            csrf: csrfToken
            image:
              tags: tags
        ).done =>
          @renderTags()

    renderTags: ->
      controlPanel = $(".image-gallery .control-panel-container")
      #rendering tags
      tags = []
      for image, i in @collection.models
        image_tags=image.get('tags')
        if image_tags?
          tags_array = image_tags.split(" ")
          for tag in tags_array
            tags.push tag
      tagsView = @tagsTemplate tags:tags
      controlPanel.append tagsView
      $(".image-gallery .tags-control-panel").on 'click', (e)=>
        e.preventDefault()
        e.stopPropagation()
        target = $(e.target)
        tag = target.attr('href')
        if tag == "#"
          @tag = null
        else
          @tag = tag
        @renderThumbs()

    renderUploadImage: ->
      controlPanel = $(".image-gallery .control-panel-container")
      #rendering upload_image
      uploadImageView = @uploadImageTemplate()
      controlPanel.append uploadImageView

      #handling events
      $(".image-gallery .delete-button").on 'click', (e)=>
        e.preventDefault()
        e.stopPropagation()
        id=$('.image-gallery .thumbs-container').data('id')
        if id?
          csrfToken = $("meta[name=csrf-token]")[0].content
          $.ajax(
            type: 'delete'
            url: "/images/#{id}"
            data:
              csrf: csrfToken
          ).done =>
            @renderTags()


    render: ->
      @$el.empty()
      @$el.append @template()

      @renderThumbs()
      @renderTags()
      @renderEditTags()
      @renderUploadImage()
      @
