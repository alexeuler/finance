$(document).on "page:change", ->
  $('#navbar .login-panel .navbar-icon').tooltip placement:'bottom'
  if $('#notice')[0]
    alert $('#notice')[0].value