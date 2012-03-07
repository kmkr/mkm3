class mkm.views.photos.ThumbnailPhotoView extends Backbone.View
  template: JST['photos/thumbnail']
  className: 'thumbnailPhotoView'
  tagName: 'li'
  views: []

  initialize: (options = {}) ->
    @thumbCollectionId = options.thumbCollectionId or "thumb"
    @size = options.size or 'small'

  rem: =>
    @remove()

  render: ->
    $(@el).html(@template({model: @model, thumbCollectionId: @thumbCollectionId, size: @size}))
    @
