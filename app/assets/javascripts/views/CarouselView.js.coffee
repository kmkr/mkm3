class mkm.views.CarouselView extends Backbone.View
  template: JST['page/carousel']

  initialize: ->
    @photos = @getPhotos()

  init: ->
    @$('> div').jcarousel({
      wrap: 'circular'
      auto: 4
      animation: "slow"
    })

  getPhotos: ->
    photos = []
    galleries = mkm.collections.articles.pluck('photos')
    for gallery in galleries
      if gallery.length isnt 0
        for p in gallery
          photos.push(p.photo)

    photos

  render: ->
    $(@el).html(@template({photos: @photos}))
    @
