# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
buttonSelector ='.video-container .modal-launch-button'
modalSelector ='.video-container #myModal'



$(document).on "page:change", ->
  modal = $(modalSelector).modal show:false
  $(buttonSelector).on 'click', ->
    $(document).trigger('image.gallery.prepare',
      modal.find('.main-body'))
    $(".image-gallery-ok-button").one 'click', (e) ->
      thumbsContainer = $('.image-gallery .thumbs-container')
      url = thumbsContainer.data('url')
      $("#video_part_image").val(url)
      modal.modal('hide')
    modal.modal('show')