class mkm.views.articles.ShowArticleView extends Backbone.View
  template: JST['articles/show']
  className: 'showArticleView'
  views: []

  initialize: (opts = {}) ->
    _.extend(@, new mkm.helpers.ArticleMapHelper())
    @model.bind('change:published', @updatePublishedStatus)
    @displayPhoto = opts.displayPhoto
    @title = @model.get('title')

  leave: ->
    @model.unbind('change:published', @updatePublishedStatus)
    clearTimeout(@timeout)

  updateFbContent: ->
    @timeout = setTimeout("FB.XFBML.parse()", 1000)
    $("meta[property='og:title']").attr('content', @model.escape('title'))
    $("meta[property='og:description']").attr('content', "#{@model.escape('body')[0..270]} ...")
    $("meta[property='og:type']").attr('content', "article")
    $("meta[property='og:url']").attr('content', "http://www.mkm.tc/articles/#{@model.get('id')}")
    if photo = @model.get('photos').at(0)
      $("meta[property='og:image']").attr('content', photo.get('photo').small.url)


  updatePublishedStatus: =>
    text = "Not yet published."
    if @model.published()
      text = "Published #{$.timeago(@model.get('published'))}."

    @$('.publish-info').html(text)

  initLightbox: ->
    numExcludedFromMatrix = @model.get('photos').articlePhotos().length
    _this = @
    mkm.helpers.lightboxHelper.init(@$('.thumb-wrapper > a'), {
      afterShow: ->
        _this.thumbnailMatrixView.paginateToPhoto(@index - numExcludedFromMatrix)
      beforeShow: ->
        id = $(@.element).attr('data-id')
        p = _this.model.get('photos').get(id)
        mkm.routers.router.navigate("articles/#{p.get('article').id}/photos/#{p.id}")
      beforeClose: ->
        mkm.routers.router.navigate("articles/#{_this.model.id}")
    })


  initImageScroll: ->
    @imgsc = new mkm.views.ImageScrollView({collection: @model.get('photos').onlyCropped() })
    @views.push(@imgsc)
    @$('.imagescroll').html(@imgsc.render().el)

  initLargeThumbs: ->
    thumbnailPhotoView = new mkm.views.photos.ThumbnailsPhotoView({ collection: @model.get('photos').articlePhotos()})
    @views.push(thumbnailPhotoView)
    @$('.photos').html(thumbnailPhotoView.render().el)

  initSmallThumbs: ->
    @thumbnailMatrixView = new mkm.views.photos.ThumbnailMatrixView({ collection: @model.get('photos').withoutArticlePhotos()})
    @views.push(@thumbnailMatrixView)
    @$('.thumbmatrix').html(@thumbnailMatrixView.render().el)

  initAdminbar: ->
    adminBarView = new mkm.views.articles.AdministerArticleBarView({ model: @model })
    @views.push(adminBarView)
    @$('.adminbar').html(adminBarView.render().el)

  init: ->
    if @displayPhoto
      @$(".thumb-wrapper > a[data-id=#{@displayPhoto.id}]").click()

    @initMap({ readOnly: true })
    @imgsc.init()
    unless @model.published()
      mkm.helpers.flash('info', 'This article is not yet published')

  initTooltips: ->
    @$('[rel=tooltip]').tooltip()

  setContent: =>
    html = textile(@model.get('body'))
    @$('.body').html(html).hide().fadeIn(600)
    @updateFbContent()
    @initTooltips()

  render: ->
    $(@el).html(@template({article: @model}))
    @initImageScroll()
    @initLargeThumbs()
    @initSmallThumbs()
    @initAdminbar()
    @initLightbox()
    @updatePublishedStatus()
    if @model.get('body')
      @setContent()
    else
      @model.fetch({ success: @setContent })
    @
