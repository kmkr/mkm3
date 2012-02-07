class mkm.views.articles.ShowArticleView extends Backbone.View
  template: JST['articles/show']

  render: ->
    $(@el).html(@template({article: @model}))
    @
