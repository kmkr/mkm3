class mkm.models.Article extends Backbone.RelationalModel
  urlRoot: "/articles"
  relations: [{
    type: Backbone.HasMany
    key: 'photos'
    relatedModel: 'mkm.models.Photo'
    collectionType: 'mkm.collections.PhotoCollection'
    reverseRelation:
      key: 'article'
      includeInJSON: 'id'
  }]

