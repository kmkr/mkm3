class mkm.routers.AppRouter extends Backbone.Router

  routes:
    ""                : "index"
    "articles/new"    : "newArticle"
    "articles/:id"    : "showArticle"

  index: ->
    @swap(new mkm.views.IndexView())

  showArticle: (id) ->
    model = mkm.collections.articles.get(id)
    if model
      @swap(new mkm.views.articles.ShowArticleView({model: model}))
    else
      mkm.helpers.flash('error', 'No such article')
      @navigate('', true)

  newArticle: ->
    @swap(new mkm.views.articles.NewArticleView())
    
  swap: (newView) ->
    @view.leave() if @view?.leave
    @view.destroy() if @view
    @view = newView
    $("#page-content").html(@view.render().el)



Backbone.View::destroy = ->
  # Destroy sub views
  if @views
    console.log("Lengde på sub views: %o %o", @views.length, @)
    for view in @views
      view.destroy()
    @views.length = 0
  
  # Perform internal view cleanup
  @leave() if @leave

  # Remove the view from the DOM.
  # This will also remove events bound to the view's private DOM-element (@el)
  @remove()
