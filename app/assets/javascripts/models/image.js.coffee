class App.Models.Image extends Backbone.Model
  urlRoot : '/images'
  img_url: ->
    token = @get('access_token')