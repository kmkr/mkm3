class mkm.views.articles.ShowArticleView extends Backbone.View
  template: JST['articles/show']
  className: 'showArticleView'
  views: []

  events: ->
    "click .publish"        : "publish"

  publish: (evt) =>
    evt.preventDefault()

    @model.save({
      published: true
    }, {
      success: =>
        mkm.helpers.flash('info', 'Article published')
        $(@el).find(".publish").hide('slow')
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
