class mkm.routers.AppRouter extends Backbone.Router

  routes:
    ""                        : "index"
    "articles/new"            : "newArticle"
    "articles/:id/photos/new" : "newPhoto"
    "articles/:id/edit"       : "editArticle"
    "articles/:id"            : "showArticle"
    "countries/:id/edit"      : "editCountry"
    "countries/new"           : "newCountry"

  index: ->
    @swap(new mkm.views.IndexView())

  showArticle: (id) ->
    model = mkm.collections.articles.get(id)
    if model
      @swap(new mkm.views.articles.ShowArticleView({model: model}))
    else
      mkm.helpers.flash('error', 'No such article')
      @navigate('', true)

  editArticle: (id) ->
    model = mkm.collections.articles.get(id)
    if model
      @swap(new mkm.views.articles.EditArticleView({model: model}))
    else
      mkm.helpers.flash('error', 'No such article')
      @navigate('', true)

  newArticle: ->
    @swap(new mkm.views.articles.EditArticleView({model: new mkm.models.Article()}))

  newPhoto: (articleId) ->
    model = mkm.collections.articles.get(articleId)
    if model
      @swap(new mkm.views.photos.NewPhotoView({model: model}))
    else
      mkm.helpers.flash('error', 'No such article')
      @navigate('', true)

  newCountry: ->
    @swap(new mkm.views.countries.EditCountryView({model: new mkm.models.Country()}))

  editCountry: (id) ->
    model = mkm.collections.countries.get(id)
    if model
      @swap(new mkm.views.countries.EditCountryView({model: model}))
    else
      mkm.helpers.flash('error', 'No such country')
      @navigate('', true)
    
  swap: (newView) ->
    @view.leave() if @view?.leave
    @view.destroy() if @view
    @view = newView
    $("#page-content").html(@view.render().el)
    @view.init() if @view.init



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
