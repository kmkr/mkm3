class mkm.views.ImageScrollView extends Backbone.View
  template: JST['page/imagescroll']

  initialize: ->
    @photos = @getPhotos()

  getPhotos: ->
    photos = []
    mkm.collections.articles.forEach((article) ->
      article.get('photos').forEach((photo) ->
        if photo.isCropped()
          photos.push(photo.get('photo'))
      )
    )

    photos

  init: ->
    @$('.nivoSlider').nivoSlider({
      effect: 'boxRandom'
      randomStart: true
      pauseTime: 8000
    })

  render: ->
    $(@el).html(@template({photos: @photos}))
    @
