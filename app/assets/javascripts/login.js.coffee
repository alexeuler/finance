$(document).on "page:change", ->
  $('#navbar #email_login').on 'click', (e)->
    e.preventDefault()
    e.stopPropagation()
    ref = $('#email_login').attr('href')
    $.ajax(
      type: 'get'
      url: ref
    ).done( (data)->
      $('#navbarModal').find('.modal-content').html(data)
    ).fail( (jqXHR, textStatus) ->
      alert( "Request failed: " + textStatus );
    )
    $('#navbarModal .modal-dialog').css
      width: 310,
      left:20
    $('#navbarModal').modal('show')