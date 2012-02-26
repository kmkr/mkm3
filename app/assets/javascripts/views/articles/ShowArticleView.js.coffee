class mkm.views.articles.ShowArticleView extends Backbone.View
  template: JST['articles/show']
  className: 'showArticleView'
  views: []

  initialize: (opts = {}) ->
    _.extend(@, new mkm.helpers.ArticleMapHelper())
    @model.bind('change:published', @updatePublishedStatus)
    @displayPhoto = opts.displayPhoto

  leave: ->
    @model.unbind('change:published', @updatePublishedStatus)

  updateFbContent: ->
    setTimeout("FB.XFBML.parse()", 1000)
    $("meta[property='og:title']").attr('content', @model.get('title'))
    if photo = @model.get('photos').at(0)
      $("meta[property='og:image']").attr('content', photo.get('photo').small.url)

  init: ->
    @initMap({ readOnly: true })
    @imgsc.init()
    @updateFbContent()
    unless @model.published()
      mkm.helpers.flash('info', 'This article is not yet published')

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

    thumbnailPhotoView = new mkm.views.photos.ThumbnailsPhotoView({ collection: @model.get('photos').articlePhotos()})
    @views.push(thumbnailPhotoView)
    @$('.photos').html(thumbnailPhotoView.render().el)

    thumbnailMatrixView = new mkm.views.photos.ThumbnailMatrixView({ collection: @model.get('photos'), displayPhoto: @displayPhoto})
    @views.push(thumbnailMatrixView)
    @$('.thumbmatrix').html(thumbnailMatrixView.render().el)

    adminBarView = new mkm.views.articles.AdministerArticleBarView({ model: @model })
    @views.push(adminBarView)
    @$('.adminbar').html(adminBarView.render().el)

    @updatePublishedStatus()

    @
