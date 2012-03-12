class mkm.models.Country extends Backbone.Model
  urlRoot: "/countries"

  articles: ->
    mkm.collections.articles.filter((article) => article.get('country_id') is @get('id'))

