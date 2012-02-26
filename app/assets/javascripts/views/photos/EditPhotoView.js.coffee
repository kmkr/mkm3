class mkm.views.photos.EditPhotoView extends Backbone.View
  template: JST['photos/edit']
  className: 'editPhotoView'
  views: []

  events: ->
    "click .crop-photo"    : "saveCropped"

  saveCropped: (e) =>
    e.preventDefault()

    @$('button').hide()
    @$('.crop-loader').show()
    @model.save({
      crop_x: @x
      crop_y: @y
      crop_h: @h
      crop_w: @w
    }, {
      success: =>
        mkm.routers.router.navigate("articles/#{@model.get('article').id}", true)
        mkm.helpers.flash('info' ,"Image cropped successfully")
      error: ->
        mkm.helpers.flash('error', "Error while uploading cropped version.")
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
      boxWidth: 920
      aspectRatio: 2.5
      # TODO: jCrop fikser ikke dette. må manuelt finne ut scale-rate
      minSize: [940, 376]
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
    v = new mkm.views.photos.SmallEditablePhotoView({model: @model})
    @$('.fields').html(v.render().el)
    @views.push(v)
    @initCrop()
    @
