class mkm.views.IndexView extends Backbone.View
  template: JST['page/index']
  views: []
  className: 'indexView'

  initialize: ->
    _.extend(@, new mkm.helpers.CountriesMapHelper())

  init: ->
    @initMap({ readOnly: true})
    @imgsc.init()

  getPhotoCollection: ->
    photos = []
    mkm.collections.articles.forEach((article) ->
      article.get('photos').forEach((photo) ->
        if photo.isCropped()
          photos.push(photo.get('photo'))
      )
    )

    new mkm.collections.PhotoCollection(photos)

  render: ->
    $(@el).html(@template)
    @imgsc = new mkm.views.ImageScrollView({collection: @getPhotoCollection() })
    @views.push(@imgsc)
    @$('.imagescroll').html(@imgsc.render().el)
    @
