class mkm.views.articles.ShowArticleView extends Backbone.View
  template: JST['articles/show']
  className: 'showArticleView'
  views: []

  events: ->
    "click .confirm"        : mkm.helpers.confirm.dialog
    "click .delete-article" : "del"
    "click .publish"        : "publish"
    "click .unpublish"      : "unpublish"

  del: (evt) =>
    evt.preventDefault()
    button = $(evt.target).closest('.btn')
    @$('.loader').show()
    button.remove()
    @model.destroy({success: ->
      mkm.helpers.flash('info', "Article removed")
      mkm.routers.router.navigate("", true)
    })
    
  unpublish: (evt) =>
    evt.preventDefault()
    @model.save({
      published: ""
    }, {
      success: =>
        mkm.helpers.flash('info', 'Article is now hidden')
        @render()
    })

  publish: (evt) =>
    evt.preventDefault()

    @model.save({
      published: new Date()
    }, {
      success: =>
        mkm.helpers.flash('info', 'Article is published')
        @render()
    })

  initialize: ->
    _.extend(@, new mkm.helpers.ArticleMapHelper())

  init: ->
    @initMap({ readOnly: true })
    @$('.gallery').galleryView({
      panel_width: 720
      panel_height: 410
      frame_width: 90
      frame_height: 90
      frame_scale: 'fit'
      frame_opacity: 0.9
      show_captions: true
    })
    @imgsc.init()

  writePublishStatus: ->
    @$('.publish-info').html("Published #{$.timeago(@model.get('published'))}.")

  render: ->
    $(@el).html(@template({article: @model}))
    @imgsc = new mkm.views.ImageScrollView({photos: @model.get('photos').onlyCropped() })
    @views.push(@imgsc)
    @$('.imagescroll').html(@imgsc.render().el)
    thumbnailPhotoView = new mkm.views.photos.ThumbnailsPhotoView({ collection: @model.get('photos')})
    @views.push(thumbnailPhotoView)
    $(@el).find('.photos').html(thumbnailPhotoView.render().el)
    @writePublishStatus() if @model.published()
    @
