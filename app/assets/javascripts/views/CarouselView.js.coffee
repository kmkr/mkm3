class mkm.views.CarouselView extends Backbone.View
  template: JST['page/carousel']

  initialize: ->
    @photos = @getPhotos()

  init: ->
    @$('.carousel').carouFredSel({
      height: '200'
      items:
        minimum: 1
        start: "random"
        height: "variable"
        width: "variable"
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
