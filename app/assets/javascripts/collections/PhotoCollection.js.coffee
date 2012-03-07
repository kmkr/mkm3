class mkm.collections.PhotoCollection extends Backbone.Collection
  model: mkm.models.Photo

  onlyCropped: ->
    @filter((p) -> p.isCropped())

  articlePhotos: ->
    @filter((p) -> p.get('useAsArticlePhoto'))

  withoutArticlePhotos: ->
    @filter((p) -> not p.get('useAsArticlePhoto'))

  frontpagePhotos: ->
    @filter((p) -> p.get('useAsFrontpagePhoto') and p.isCropped())

  comparator: (photo) ->
    photo.get('position')
