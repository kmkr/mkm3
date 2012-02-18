class mkm.views.CarouselView extends Backbone.View
  template: JST['page/carousel']

  initialize: ->
    @photos = @getPhotos()

  init: ->
    @$('> div').jcarousel({
      wrap: 'circular'
      auto: 4
      animation: "slow"
      scroll: 2
    })

  getPhotos: ->
    photos = []
    mkm.collections.articles.forEach((article) ->
      article.get('photos').forEach((photo) ->
        photos.push(photo.get('photo'))
      )
    )

    photos

  render: ->
    $(@el).html(@template({photos: @photos}))
    @
