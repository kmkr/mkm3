class mkm.views.articles.ShowArticleView extends Backbone.View
  template: JST['articles/show']
  className: 'showArticleView'
  views: []

  events: ->
    "click .publish"        : "publish"
    "click .unpublish"      : "unpublish"

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

  render: ->
    $(@el).html(@template({article: @model}))
    thumbnailPhotoView = new mkm.views.photos.ThumbnailsPhotoView({ model: @model})
    @views.push(thumbnailPhotoView)
    $(@el).find('.photos').html(thumbnailPhotoView.render().el)
    @
