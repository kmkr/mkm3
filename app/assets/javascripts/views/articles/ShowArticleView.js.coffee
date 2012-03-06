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

  initLightbox: ->
    mkm.helpers.lightboxHelper.init(@$('.thumb-wrapper > a'), {
      afterShow: (lightbox) =>
        #@paginate(Math.ceil((lightbox.index + 1) / (@columns*@rows)))
      beforeShow: (lightbox) =>
        id = $(lightbox.element).attr('data-id')
        p = @model.get('photos').get(id)
        mkm.routers.router.navigate("articles/#{p.get('article').id}/photos/#{p.id}")
      beforeClose: (lightbox) =>
        mkm.routers.router.navigate("articles/#{@model.id}")
    })


  initImageScroll: ->
    @imgsc = new mkm.views.ImageScrollView({collection: new mkm.collections.PhotoCollection(@model.get('photos').onlyCropped()) })
    @views.push(@imgsc)
    @$('.imagescroll').html(@imgsc.render().el)

  initLargeThumbs: ->
    thumbnailPhotoView = new mkm.views.photos.ThumbnailsPhotoView({ collection: @model.get('photos').articlePhotos()})
    @views.push(thumbnailPhotoView)
    @$('.photos').html(thumbnailPhotoView.render().el)

  initSmallThumbs: ->
    thumbnailMatrixView = new mkm.views.photos.ThumbnailMatrixView({ collection: new mkm.collections.PhotoCollection(@model.get('photos').withoutArticlePhotos())})
    @views.push(thumbnailMatrixView)
    @$('.thumbmatrix').html(thumbnailMatrixView.render().el)

  initAdminbar: ->
    adminBarView = new mkm.views.articles.AdministerArticleBarView({ model: @model })
    @views.push(adminBarView)
    @$('.adminbar').html(adminBarView.render().el)

  init: ->
    if @displayPhoto
      @$(".thumb-wrapper > a[data-id=#{@displayPhoto.id}]").click()

  render: ->
    $(@el).html(@template({article: @model}))
    @initImageScroll()
    @initLargeThumbs()
    @initSmallThumbs()
    @initAdminbar()
    @initLightbox()
    @updatePublishedStatus()
    @
