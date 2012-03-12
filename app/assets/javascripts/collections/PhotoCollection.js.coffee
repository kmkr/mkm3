class mkm.collections.PhotoCollection extends Backbone.Collection
  model: mkm.models.Photo

  onlyCropped: ->
    @_wrap((@filter((p) -> p.isCropped())))

  articlePhotos: ->
    @_wrap(@filter((p) -> p.get('useAsArticlePhoto')))

  withoutArticlePhotos: ->
    @_wrap(@filter((p) -> not p.get('useAsArticlePhoto')))

  frontpagePhotos: ->
    @_wrap(@filter((p) -> p.get('useAsFrontpagePhoto') and p.isCropped()))

  comparator: (photo) ->
    photo.get('position')

  _wrap: (photos) ->
    new mkm.collections.PhotoCollection(photos)
