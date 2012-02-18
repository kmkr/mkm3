class mkm.views.photos.ThumbnailsPhotoView extends Backbone.View
  template: JST['photos/thumbnails']
  className: 'thumbnailsPhotoView'
  views: []

  events:
    "click .delete-photo"   : "deletePhoto"

  deletePhoto: (evt) ->
    evt.preventDefault()
    id = Number($(evt.target).attr('data-id'))
    photo = @collection.get(id)
    photo.destroy({
      success: =>
        # todo: fjern photo fra collection
        @render()
    })

  render: ->
    @collection = new mkm.collections.PhotoCollection(@model.get('photos'))
    $(@el).html(@template({collection: @collection}))
    @
