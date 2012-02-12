class mkm.views.articles.ShowArticleView extends Backbone.View
  template: JST['articles/show']
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
    _.extend(@, new mkm.helpers.MapHelper())

  init: ->
    @initMap({ readOnly: true })

  render: ->
    $(@el).html(@template({article: @model}))
    thumbnailPhotoView = new mkm.views.photos.ThumbnailsPhotoView({ collection: new mkm.collections.PhotoCollection(@model.get('photos')) })
    @views.push(thumbnailPhotoView)
    $(@el).find('.photos').html(thumbnailPhotoView.render().el)
    @
