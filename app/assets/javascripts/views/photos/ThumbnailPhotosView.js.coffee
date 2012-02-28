class mkm.views.photos.ThumbnailsPhotoView extends Backbone.View
  template: JST['photos/thumbnails']
  className: 'thumbnailsPhotoView'
  views: []

  render: ->
    $(@el).html(@template)
    @collection.forEach((photo) =>
      v = new mkm.views.photos.ThumbnailPhotoView({model: photo, size: 'medium'})
      @views.push(v)
      @$('ul').append($(v.render().el).addClass('span5'))
    )

    @
