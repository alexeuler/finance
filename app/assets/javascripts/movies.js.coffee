prepare = (event, parent) ->
  parent =$(parent)
  movies_collection = new App.Collections.Movies
  view = new App.Views.Movies.Index(collection: movies_collection)
  parent.html(view.$el)
  movies_collection.fetch()


$(document).on "page:change", ->
  $(document).on "movie.gallery.prepare", prepare