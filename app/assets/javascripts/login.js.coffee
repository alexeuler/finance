initValidator = ->
  userForm = $('form#new_user')
  userForm.find('input[type="submit"]').on 'click', (e)->
    unless userForm.valid()
      e.preventDefault()
      e.stopPropagation()

  userForm.validate
    rules:
      'user[email]':
        email:true,
        required:true
      'user[password]':
        required:true
      'user[password_confirmation]':
        required:true
      'user[first_name]':
        required:true
    messages:
      'user[email]':
        email:$("input#user_email").data('email-message'),
        required:$("input#user_email").data('required-message'),
      'user[password]':
        required:$("input#user_password").data('required-message'),
      'user[password_confirmation]':
        required:$("input#user_password_confirmation").data('required-message'),
      'user[first_name]':
        required:$("input#user_first_name").data('required-message'),

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
        initValidator()
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
