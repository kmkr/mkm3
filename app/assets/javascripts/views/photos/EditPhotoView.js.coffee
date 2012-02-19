class mkm.views.photos.EditPhotoView extends Backbone.View
  template: JST['photos/edit']
  className: 'editPhotoView'

  events: ->
    "click button"    : "saveCropped"

  saveCropped: (e) =>
    e.preventDefault()

    @$('button').hide()
    @$('.loader').show()
    @model.save({
      crop_x: @x
      crop_y: @y
      crop_h: @h
      crop_w: @w
    }, {
      success: =>
        @$('button').show()
        @$('.loader').hide()
        mkm.helpers.flash.info("Image cropped successfully")
      error: ->
        mkm.helpers.flash.error("Error while uploading cropped version.")
    })

  showCoords: (c) =>
    @x = c.x
    @y = c.y
    @w = c.w
    @h = c.h

  initCrop: ->
    model = @model
    that = @
    @$('img.photo').Jcrop({
      bgOpacity: 0.5
      addClass: 'jcrop-light'
      onSelect: @showCoords
      onChange: @showCoords
      aspectRatio: 2.42
      # TODO: jCrop fikser ikke dette. må manuelt finne ut scale-rate
      minSize: [968, 400]
    }, ->
      # oh my god..
      that.setApi(@)
      if model.isCropped()
        @animateTo(model.cropped())
    )

  setApi: (api) ->
    @api = api


  render: ->
    $(@el).html(@template({photo: @model}))
    @initCrop()
    @
