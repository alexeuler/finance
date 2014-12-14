
window.App=
  Models: {}
  Collections: {}
  Views: {}
  Routers: {}

prepare = (event, parent) ->
  parent =$(parent)
  parent.html('Yo')

$(document).on "page:change", ->
  $(document).on "image.gallery.prepare", prepare


