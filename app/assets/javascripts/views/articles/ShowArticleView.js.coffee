class mkm.views.articles.ShowArticleView extends Backbone.View
  template: JST['articles/show']

  initialize: ->
    _.extend(@, new mkm.helpers.MapHelper())

  init: ->
    @initMap({ readOnly: true })

  render: ->
    $(@el).html(@template({article: @model}))
    @
