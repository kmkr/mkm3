class mkm.views.IndexView extends Backbone.View
  template: JST['page/index']
  views: []
  className: 'indexView'

  init: ->
    @imgsc.init()

  getPhotos: ->
    photos = []
    coll = new mkm.collections.PhotoCollection()
    mkm.collections.articles.forEach((article) ->
      article.get('photos').forEach((photo) ->
        coll.add(photo)
      )
    )

    coll.frontpagePhotos()

  render: ->
    $(@el).html(@template)
    @imgsc = new mkm.views.ImageScrollView({
      collection: @getPhotos()
      link: true
      captionType: 'widescreenCaption'
      nivoExtensions:
        directionNav: false
    })
    @views.push(@imgsc)
    @$('.imagescroll').html(@imgsc.render().el)
    @
