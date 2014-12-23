$(document).on "page:change", ->
  modalDialog = $('#navbarModal')
  modalDialog.modal show:false

  toggleButtons = (state)->
    if state == true
      modalDialog.find('input, button').removeClass('disabled')
    else
      modalDialog.find('input, button').addClass('disabled')

  modalDialog.on 'click', 'a', (e)->
    e.preventDefault()
    e.stopPropagation()
    clicked = $(e.currentTarget)
    ref = clicked.attr('href')

    $.ajax(
      type: 'get'
      url: ref
    ).done( (data)->
      toggleButtons(true)
      modalDialog.modal('hide')
      modalDialog.one 'hidden.bs.modal', ->
        modalDialog.find('.modal-content').html(data)
        modalDialog.modal('show')
    ).fail( (jqXHR, textStatus) ->
      toggleButtons(true)
      alert( "Request failed: " + textStatus );
    )

  modalDialog.on 'ajax:before', (e)->
    toggleButtons(false)
  modalDialog.on 'ajax:success', (e)->
    toggleButtons(true)
    location.reload()
  modalDialog.on 'ajax:error', (e, xhr, status, error)->
    toggleButtons(true)
    modalDialog.find('.errors').html(xhr.responseText)

  $('#navbar #email_login').on 'click', (e)->
    e.preventDefault()
    e.stopPropagation()
    ref = $('#email_login').attr('href')
    $.ajax(
      type: 'get'
      url: ref
    ).done( (data)->
      modalDialog.find('.modal-content').html(data)
      modalDialog.modal('show')
    ).fail( (jqXHR, textStatus) ->
      alert( "Request failed: " + textStatus );
    )
