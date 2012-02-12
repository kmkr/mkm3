class mkm.models.Photo extends Backbone.Model
  urlRoot: ->
    "/articles/#{@get('article_id')}/photos"
