class mkm.models.Photo extends Backbone.RelationalModel
  urlRoot: ->
    "/articles/#{@get('article_id')}/photos"
