
prepare = (event, parent) ->
  parent =$(parent)
  images_collection = new App.Collections.Images
  view = new App.Views.Images.Index(collection: images_collection)
  parent.html(view.$el)
  images_collection.fetch()


$(document).on "page:change", ->
  $(document).on "image.gallery.prepare", prepare


