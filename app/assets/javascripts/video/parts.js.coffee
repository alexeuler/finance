# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
modalSelector ='.video-container #myModal'



$(document).on "page:change", ->
  modal = $(modalSelector).modal show:false

  $('#add_image_button').on 'click', ->
    $(document).trigger('image.gallery.prepare',
      modal.find('.main-body'))
    $(".image-gallery-ok-button").one 'click', (e) ->
      thumbsContainer = $('.image-gallery .thumbs-container')
      url = thumbsContainer.data('url')
      $("#video_part_image").val(url)
      modal.modal('hide')
    modal.modal('show')

  $('#add_image_to_body_button').on 'click', ->
    $(document).trigger('image.gallery.prepare',
      modal.find('.main-body'))
    $(".image-gallery-ok-button").one 'click', (e) ->
      thumbsContainer = $('.image-gallery .thumbs-container')
      url = thumbsContainer.data('url')
      text = "<img src='#{url}' alt=''></img>"
      $("#video_part_body").val($("#video_part_body").val()+text)
      modal.modal('hide')
    modal.modal('show')

  $('#add_movie_to_body_button').on 'click', ->
    $(document).trigger('movie.gallery.prepare',
      modal.find('.main-body'))
    $(".movie-gallery-ok-button").one 'click', (e) ->
      thumbsContainer = $('.movie-gallery .thumbs-container')
      url = thumbsContainer.data('url')
      text = "<img src='#{url}' alt=''></img>"
      $("#video_part_body").val($("#video_part_body").val()+text)
      modal.modal('hide')
    modal.modal('show')