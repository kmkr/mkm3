class mkm.views.ImageScrollView extends Backbone.View
  template: JST['page/imagescroll']

  initialize: ->
    @photos = @getPhotos()

  getPhotos: ->
    photos = []
    mkm.collections.articles.forEach((article) ->
      article.get('photos').forEach((photo) ->
        photos.push(photo.get('photo'))
      )
    )

    photos

  init: ->
    @$('.nivoSlider').nivoSlider({
      effect: 'fade'
      randomStart: true
      pauseTime: 5000
    })

  render: ->
    $(@el).html(@template({photos: @photos}))
    @
