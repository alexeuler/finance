
window.App=
  Models: {}
  Collections: {}
  Views: {}
  Routers: {}

prepare = ->
  alert '123'

$(document).on "page:change", ->
  $(document).on "image.gallery.prepare", prepare
  $(document).trigger "image.gallery.prepare" #to prepare it in case of ajax


