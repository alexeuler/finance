$(document).on "page:change", ->
  $('#navbar #email_login').on 'click', (e)->
    e.preventDefault()
    e.stopPropagation()
    ref = $('#email_login').attr('href')
    $.ajax(
      type: 'get'
      url: ref
    ).done( (data)->
      console.log data
      $('#email_login').find('.modal-content').html(data)
    ).fail( (jqXHR, textStatus) ->
      alert( "Request failed: " + textStatus );
    )
#    $.ajax(
#      type: 'patch'
#      url: "/images/#{id}"
#    ).done( =>
#    @collection.fetch()
#    @toggleButtons(true)
#  ).fail( (jqXHR, textStatus) =>
#    alert( "Request failed: " + textStatus );
#    @toggleButtons(true)
#  )

    $('#navbarModal').modal('show')