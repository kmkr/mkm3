class mkm.views.articles.ShowArticleView extends Backbone.View
  template: JST['articles/show']
  className: 'showArticleView'
  views: []

  initialize: ->
    _.extend(@, new mkm.helpers.ArticleMapHelper())
    @model.bind('change:published', @updatePublishedStatus)

  leave: ->
    @model.unbind('change:published', @updatePublishedStatus)

  init: ->
    @initMap({ readOnly: true })
    @imgsc.init()

  updatePublishedStatus: =>
    text = "Not yet published."
    if @model.published()
      text = "Published #{$.timeago(@model.get('published'))}."

    @$('.publish-info').html(text)

  render: ->
    $(@el).html(@template({article: @model}))
    @imgsc = new mkm.views.ImageScrollView({photos: @model.get('photos').onlyCropped() })
    @views.push(@imgsc)
    @$('.imagescroll').html(@imgsc.render().el)

    thumbnailPhotoView = new mkm.views.photos.ThumbnailsPhotoView({ collection: @model.get('photos').articleImages()})
    @views.push(thumbnailPhotoView)
    @$('.photos').html(thumbnailPhotoView.render().el)

    thumbnailMatrixView = new mkm.views.photos.ThumbnailMatrixView({ collection: @model.get('photos')})
    @views.push(thumbnailMatrixView)
    @$('.thumbmatrix').html(thumbnailMatrixView.render().el)

    adminBarView = new mkm.views.articles.AdministerArticleBarView({ model: @model })
    @views.push(adminBarView)
    @$('.adminbar').html(adminBarView.render().el)

    @updatePublishedStatus()

    @
