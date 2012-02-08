class mkm.views.articles.ShowArticleView extends Backbone.View
  template: JST['articles/show']

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
    @
