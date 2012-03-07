class mkm.views.photos.EditPhotoView extends Backbone.View
  template: JST['photos/edit']
  className: 'editPhotoView'
  views: []

  events: ->
    "click .crop-photo"    : "saveCropped"
    "click .delete-crop"   : "deleteCropped"

  toggleLoad: ->
    @$('button').toggle()
    @$('.crop-loader').toggle()

  deleteCropped: (e) =>
    e.preventDefault()
    @toggleLoad()

    @model.save({
      crop_x: null
      crop_y: null
      crop_h: null
      crop_w: null
    }, {
      success: =>
        mkm.helpers.flash('info' ,"Successfully removed crop.")
        @leave()
        @render()
        @init()
      error: ->
        mkm.helpers.flash('error', "Error while updating.")
        @toggleLoad()
    })

  leave: ->
    @api.destroy()

  saveCropped: (e) =>
    e.preventDefault()

    @toggleLoad()
    @model.save({
      crop_x: @x
      crop_y: @y
      crop_h: @h
      crop_w: @w
    }, {
      success: =>
        mkm.helpers.flash('info' ,"Successfully cropped photo")
        @toggleLoad()
      error: ->
        mkm.helpers.flash('error', "Error while uploading cropped version.")
        @toggleLoad()
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
      boxWidth: 940
      aspectRatio: 2.5
      minSize: [940, 376]
    }, ->
      # oh my god..
      that.setApi(@)
      if model.isCropped()
        @animateTo(model.cropped())
    )

  setApi: (api) ->
    @api = api

  init: ->
    @initCrop()

  render: ->
    $(@el).html(@template({photo: @model}))
    @$('.delete-crop').attr('disabled', 'disabled') unless @model.isCropped()
    @
