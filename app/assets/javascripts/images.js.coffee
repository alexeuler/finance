# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

bodySelector = '.image-gallery'
containerSelector = '.image-gallery .image-container'
gallerySelector = '.image-gallery .images-container'
deleteFormSelector = '.button_to'

addClickEvents = ->
  $(containerSelector).on 'click',(e) ->
    container = $(e.currentTarget)
    $(containerSelector).removeClass('selected')
    container.addClass('selected')
    id=container.data('id')
    $(deleteFormSelector).attr('action',"/images/#{id}")

prepare = ->
  $('#new_image').on 'ajax:success', (e, data, status, xhr) ->
    response = xhr.responseText
    regex = /error/i
    if response.match(regex)
      alert response
    else
      $(gallerySelector).html(response)
      addClickEvents()
  $('#new_image').on 'ajax:error', (e, data, status, xhr) ->
    alert 'Error sending ajax request'
  $('#delete_image').on 'ajax:success', (e, data, status, xhr) ->
    response = xhr.responseText
    regex = /error/i
    if response.match(regex)
      alert response
    else
      $(gallerySelector).html(response)
      $(document).trigger "image.gallery.prepare"
  $('#delete_image').on 'ajax:error', (e, data, status, xhr) ->
    alert 'Error sending ajax request'

  addClickEvents()


$(document).on "page:change", ->
  $(document).on "image.gallery.prepare", prepare
  $(document).trigger "image.gallery.prepare" #to prepare it in case of ajax


