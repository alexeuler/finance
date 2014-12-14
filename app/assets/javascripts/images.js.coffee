
prepare = (event, parent) ->
  parent =$(parent)
  images_collection = new App.Collections.Images
  images_collection.fetch()
  view = new App.Views.Images.Index(collection: images_collection)
  parent.html(view.$el)

$(document).on "page:change", ->
  $(document).on "image.gallery.prepare", prepare


