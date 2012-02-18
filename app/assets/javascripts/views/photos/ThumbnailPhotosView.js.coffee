class mkm.views.photos.ThumbnailsPhotoView extends Backbone.View
  template: JST['photos/thumbnails']
  className: 'thumbnailsPhotoView'
  views: []

  events:
    "click .delete-photo"   : "deletePhoto"

  deletePhoto: (evt) ->
    evt.preventDefault()
    button = $(evt.target).closest('[data-id]')
    button.after($('<img src="/assets/loader.gif" />'))
    id = Number(button.attr('data-id'))
    button.remove()
    console.log("Deleting photo id=%s", id)
    photo = @model.get('photos').get(id)
    
    photo.destroy({ success: => @render() })

  render: ->
    @collection = @model.get('photos')
    $(@el).html(@template({collection: @collection}))
    @
