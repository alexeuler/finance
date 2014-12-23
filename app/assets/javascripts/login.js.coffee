$(document).on "page:change", ->
  modalDialog = $('#navbarModal')
  modalDialog.modal show:false
  modalDialog.on 'click', 'a', (e)->
    e.preventDefault()
    e.stopPropagation()
    clicked = $(e.currentTarget)
    ref = clicked.attr('href')
    $.ajax(
      type: 'get'
      url: ref
    ).done( (data)->
      modalDialog.modal('hide')
      modalDialog.one 'hidden.bs.modal', ->
        modalDialog.find('.modal-content').html(data)
        modalDialog.modal('show')
    ).fail( (jqXHR, textStatus) ->
      alert( "Request failed: " + textStatus );
    )

#    form = $('#navbarModal form')



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
