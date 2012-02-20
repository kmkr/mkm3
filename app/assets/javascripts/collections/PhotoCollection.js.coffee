class mkm.collections.PhotoCollection extends Backbone.Collection
  model: mkm.models.Photo

  onlyCropped: ->
    @filter((p) -> p.isCropped())
