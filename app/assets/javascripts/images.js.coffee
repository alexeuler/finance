# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

bodySelector = '.image-gallery'
containerSelector = '.image-gallery .image-container'
gallerySelector = '.image-gallery .images-container .panel-section'
deleteFormSelector = '.image-gallery .button_to'
updateFormSelector = '.image-gallery #update_tags_form'

buttonsState = (state) ->
  $('#add_button').prop('disabled', state)
  $('#delete_button').prop('disabled', state)
  $('#delete_button').prop('disabled', true) if $('.selected').length is 0

addClickEvents = ->
  $(containerSelector).on 'click',(e) ->
    $('#delete_button').prop('disabled', false)
    container = $(e.currentTarget)
    $(containerSelector).removeClass('selected')
    container.addClass('selected')
    id=container.data('id')
    $(deleteFormSelector).attr('action',"/images/#{id}")
    $(updateFormSelector).attr('action',"/images/#{id}")
    $.ajax(url:"/images/#{id}").done (data, textStatus, jqXHR)->
      $(updateFormSelector).find('input#image_tags').val data

prepare = ->
  $('#new_image').on 'ajax:before', ->
    buttonsState(true)

  $('#new_image').on 'ajax:success', (e, data, status, xhr) ->
    response = xhr.responseText
    regex = /error/i
    if response.match(regex)
      alert response
    else
      $(gallerySelector).html(response)
      addClickEvents()
    buttonsState(false)

  $('#new_image').on 'ajax:error', (e, data, status, xhr) ->
    buttonsState(false)
    alert 'Error sending ajax request'

  $('#delete_image').on 'ajax:before', ->
    buttonsState(true)

  $('#delete_image').on 'ajax:success', (e, data, status, xhr) ->
    response = xhr.responseText
    regex = /error/i
    if response.match(regex)
      alert response
    else
      $(gallerySelector).html(response)
      $(document).trigger "image.gallery.prepare"
    buttonsState(false)
  $('#delete_image').on 'ajax:error', (e, data, status, xhr) ->
    buttonsState(false)
    alert 'Error sending ajax request'

  addClickEvents()


$(document).on "page:change", ->
  $('#delete_button').prop('disabled', true);
  $(document).on "image.gallery.prepare", prepare
  $(document).trigger "image.gallery.prepare" #to prepare it in case of ajax


