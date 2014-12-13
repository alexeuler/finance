# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

bodySelector = '.image-gallery'
containerSelector = '.image-gallery .image-container'
deleteFormSelector = '.button_to'

addClickEvents = ->
  $(containerSelector).on 'click',(e) ->
    container = $(e.currentTarget)
    $(containerSelector).removeClass('selected')
    container.addClass('selected')
    id=container.data('id')
    $(deleteFormSelector).attr('action',"/images/#{id}")


$(document).on "page:change", ->
  $(document).on "image.gallery.prepare", addClickEvents
  $(document).trigger "image.gallery.prepare" #to prepare it in case of ajax


