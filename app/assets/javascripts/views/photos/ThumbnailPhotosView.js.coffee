class mkm.views.photos.ThumbnailsPhotoView extends Backbone.View
  template: JST['photos/thumbnails']
  views: []

  render: ->
    $(@el).html(@template({collection: @collection}))
    @
