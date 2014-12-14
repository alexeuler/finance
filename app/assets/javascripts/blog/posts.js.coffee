# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

buttonSelector ='.blog-post-form-body .modal-launch-button'
modalSelector ='.blog-post-form-body #myModal'



$(document).on "page:change", ->
  modal = $(modalSelector).modal show:false
  $(buttonSelector).on 'click', ->
    $(document).trigger('image.gallery.prepare',
      modal.find('.modal-body'))
    modal.modal('show')

