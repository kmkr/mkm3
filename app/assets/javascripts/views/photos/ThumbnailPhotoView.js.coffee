class mkm.views.photos.ThumbnailPhotoView extends Backbone.View
  template: JST['photos/thumbnail']
  className: 'thumbnailPhotoView'
  views: []

  events:
    "click .delete-photo"   : "deletePhoto"

  deletePhoto: (evt) ->
    evt.preventDefault()
    @$('.btn').remove()
    @$('.loader').show()
    
    @model.destroy({ success: => @remove() })

  render: ->
    $(@el).html(@template({model: @model}))
    @
