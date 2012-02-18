class mkm.views.photos.ThumbnailsPhotoView extends Backbone.View
  template: JST['photos/thumbnails']
  className: 'thumbnailsPhotoView'
  views: []

  events:
    "click .delete-photo"   : "deletePhoto"

  deletePhoto: (evt) ->
    evt.preventDefault()
    id = Number($(evt.target).closest('[data-id]').attr('data-id'))
    console.log("prøver å slette %s", id)
    photo = @model.get('photos').get(id)
    console.log("før slett: photo size er %s", @model.get('photos').length)
    photo.destroy({
      success: =>
        console.log("etter slett: photo size er %s", @model.get('photos').length)
        @render()
    })

  render: ->
    @collection = @model.get('photos')
    $(@el).html(@template({collection: @collection}))
    @
