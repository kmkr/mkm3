class mkm.views.photos.ThumbnailsPhotoView extends Backbone.View
  template: JST['photos/thumbnails']
  className: 'thumbnailsPhotoView'
  views: []

  render: ->
    $(@el).html(@template)
    @collection.forEach((photo) =>
      v = new mkm.views.photos.ThumbnailPhotoView({model: photo})
      @views.push(v)
      $(@el).append(v.render().el)
    )

    @
