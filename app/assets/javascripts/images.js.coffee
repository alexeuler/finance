# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

bodySelector = '.image-gallery'
containerSelector = '.image-gallery .image-container'
deleteFormSelector = '.button_to'

prepare = ->
  $('#new_image').on 'ajax:success', (e, data, status, xhr) ->
    console.log xhr
  $('#new_image').on 'ajax:error', (e, data, status, xhr) ->
    alert 'Error sending ajax request'
  $('#delete_image').on 'ajax:success', (e, data, status, xhr) ->
    console.log xhr
  $('#delete_image').on 'ajax:error', (e, data, status, xhr) ->
    alert 'Error sending ajax request'




  $(containerSelector).on 'click',(e) ->
    container = $(e.currentTarget)
    $(containerSelector).removeClass('selected')
    container.addClass('selected')
    id=container.data('id')
    $(deleteFormSelector).attr('action',"/images/#{id}")


$(document).on "page:change", ->
  $(document).on "image.gallery.prepare", prepare
  $(document).trigger "image.gallery.prepare" #to prepare it in case of ajax


