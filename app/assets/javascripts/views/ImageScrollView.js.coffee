class mkm.views.ImageScrollView extends Backbone.View
  template: JST['page/imagescroll']

  initialize: (opts) ->
    @collection = new mkm.collections.PhotoCollection(opts.photos)

  init: ->
    @$('.nivoSlider').nivoSlider({
      effect: 'boxRandom'
      randomStart: true
      pauseTime: 8000
    })

  render: ->
    photos = @collection.onlyCropped()
    if photos.length isnt 0
      $(@el).html(@template({photos: @collection.onlyCropped()}))
    @
