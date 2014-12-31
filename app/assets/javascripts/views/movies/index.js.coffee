App.namespace 'App.Views.Movies', (ns)->
  class ns.Index extends Backbone.View

    tagName:'div'
    className:'movies-container'

    thumbTemplate:JST['templates/movies/thumb']
    controlPanelTemplate:JST['templates/movies/control_panel']
    tagsTemplate:JST['templates/movies/tags']
    editTagsTemplate:JST['templates/movies/edit_tags']
    uploadmovieTemplate:JST['templates/movies/upload_movie']
    template:JST['templates/movies/index']

    initialize: ->
      _.bindAll @, 'render', 'renderThumbs', 'renderTags',
        'renderEditTags', 'renderUploadmovie'
      @listenTo(@collection, 'sync', @render)
      @render()

    toggleButtons: (value) ->
      buttons = $('.movie-gallery').find('.add-button, .delete-button, .edit-tags-button')
      if value
        buttons.removeClass('disabled')
      else
        buttons.addClass('disabled')

    renderThumbs: ->
      #rendering thumbs
      thumbsContainer = $('.movie-gallery .thumbs-container')
      thumbsContainer.empty()
      for movie, i in @collection.models
        #if tags string contains @tag
        if not @tag? or movie.get('tags')?.indexOf(@tag) > -1
          thumbs_view = @thumbTemplate({
            id:movie.get('id'),
            url:movie.get('url_small')
          })
          thumbsContainer.append thumbs_view

      #handling events
      thumbsContainer.find(".movie-thumb-container").on "click", (e) =>
        id = $(e.currentTarget).data('id')
        model = @collection.get(id)
        url = model.get('url')
        thumbsContainer.data('id', id)
        thumbsContainer.data('url', url)

        thumbsContainer.find(".movie-thumb-container").removeClass('selected')
        $(e.currentTarget).addClass('selected')
        model = @collection.get(id)
        tags = model.get('tags')
        $(".movie-gallery #movie_tags").val(tags)


    renderEditTags: ->
      controlPanel = $(".movie-gallery .control-panel-container")
      #rendering edit_tags
      editTagsView = @editTagsTemplate()
      controlPanel.append editTagsView

      updateButton = controlPanel.find(".edit-tags-button")
      updateButton.on 'click', =>
        id=$('.movie-gallery .thumbs-container').data('id')
        if id?
          tags=controlPanel.find("#movie_tags").val()
          csrfToken = $("meta[name=csrf-token]")[0].content
          @toggleButtons(false)
          $.ajax(
            type: 'patch'
            url: "/movies/#{id}"
            data:
              csrf: csrfToken
              movie:
                tags: tags
          ).done( =>
            @collection.fetch()
            @toggleButtons(true)
          ).fail( (jqXHR, textStatus) =>
            alert( "Request failed: " + textStatus );
            @toggleButtons(true)
          )
        else
          alert("Error: movie is not selected")


    renderTags: ->
      controlPanel = $(".movie-gallery .control-panel-container")
      #rendering tags
      tags = []
      for movie, i in @collection.models
        movie_tags=movie.get('tags')
        if movie_tags?
          tags_array = movie_tags.split(" ")
          for tag in tags_array
            tags.push tag
      tags = _.uniq(tags)
      tagsView = @tagsTemplate tags:tags
      controlPanel.append tagsView
      $(".movie-gallery .tags-control-panel").on 'click', (e)=>
        e.preventDefault()
        e.stopPropagation()
        target = $(e.target)
        tag = target.attr('href')
        if tag == "#"
          @tag = null
        else
          @tag = tag
        @renderThumbs()

    renderUploadmovie: ->
      controlPanel = $(".movie-gallery .control-panel-container")
      #rendering upload_movie
      uploadmovieView = @uploadmovieTemplate()
      controlPanel.append uploadmovieView

      #handling events
      $(".movie-gallery .add-button").on 'click', (e) =>
        @toggleButtons(false)

      $(".movie-gallery .new_movie").on('ajax:success', (e)=>
        @collection.fetch()
        @toggleButtons(true)
      ).on('ajax:error', =>
        alert "Error on server side"
        @toggleButtons(true)
      )

      $(".movie-gallery .delete-button").on 'click', (e)=>
        e.preventDefault()
        e.stopPropagation()
        id=$('.movie-gallery .thumbs-container').data('id')
        if id?
          csrfToken = $("meta[name=csrf-token]")[0].content
          @toggleButtons(false)
          $.ajax(
            type: 'delete'
            url: "/movies/#{id}"
            data:
              csrf: csrfToken
          ).done( =>
            @collection.fetch()
            @toggleButtons(true)
          ).fail( (jqXHR, textStatus) =>
            alert( "Request failed: " + textStatus );
            @toggleButtons(true)
          )
        else
          alert("Error: movie is not selected")



    render: ->
      @$el.empty()
      @$el.append @template()

      @renderThumbs()
      @renderTags()
      @renderEditTags()
      @renderUploadmovie()
      @
