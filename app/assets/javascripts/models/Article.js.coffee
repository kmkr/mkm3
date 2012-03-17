class mkm.models.Article extends Backbone.RelationalModel
  urlRoot: "/articles"
  relations: [{
    type: Backbone.HasMany
    key: 'photos'
    relatedModel: 'mkm.models.Photo'
    collectionType: 'mkm.collections.PhotoCollection'
    reverseRelation:
      key: 'article'
      includeInJSON: false
  }]

  published: ->
    if @get('published') then true else false

  country: ->
    mkm.collections.countries.find((country) => _.indexOf(country.articles(), @) > -1)
