class mkm.views.IndexView extends Backbone.View
  template: JST['page/index']
  views: []
  className: 'indexView'

  initialize: ->
    _.extend(@, new mkm.helpers.CountriesMapHelper())

  init: ->
    @initMap({ readOnly: true})
    @imgsc.init()

  getPhotos: ->
    photos = []
    mkm.collections.articles.forEach((article) ->
      article.get('photos').forEach((photo) ->
        photos.push(photo)
      )
    )

    photos

  render: ->
    $(@el).html(@template)
    @imgsc = new mkm.views.ImageScrollView({ photos: @getPhotos() })
    @views.push(@imgsc)
    @$('.imagescroll').html(@imgsc.render().el)
    @
