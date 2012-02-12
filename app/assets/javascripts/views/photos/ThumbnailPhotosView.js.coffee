class mkm.views.photos.ThumbnailsPhotoView extends Backbone.View
  template: JST['photos/thumbnails']
  views: []

  render: ->
    console.log(@collection)
    $(@el).html(@template({collection: @collection}))
    @
