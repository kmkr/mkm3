class mkm.views.photos.ThumbnailPhotoView extends Backbone.View
  template: JST['photos/thumbnail']
  className: 'thumbnailPhotoView'
  views: []

  initialize: (options = {}) ->
    @thumbCollectionId = options.thumbCollectionId or "thumb"
    @model.bind('destroy', @rem)

  leave: ->
    @model.unbind('destroy', @rem)

  rem: =>
    @remove()

  events:
    "click .delete-photo"   : "deletePhoto"

  deletePhoto: (evt) ->
    evt.preventDefault()
    @$('.btn').remove()
    @$('.loader').show()
    
    @model.destroy({ wait: true })

  render: ->
    $(@el).html(@template({model: @model, thumbCollectionId: @thumbCollectionId}))
    @
