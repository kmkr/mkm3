class mkm.routers.AppRouter extends Backbone.Router

  routes:
    ""                        : "index"
    "articles/new"            : "newArticle"
    "articles/:id/photos/new" : "newPhoto"
    "articles/:aId/photos/:pId/edit": "editPhoto"
    "articles/:aId/photos/:pId": "showPhoto"
    "articles/:id/edit"       : "editArticle"
    "articles/:id"            : "showArticle"
    "countries/:id/edit"      : "editCountry"
    "countries/new"           : "newCountry"
    "*path"                   : "notFound"

  index: ->
    @swap(new mkm.views.IndexView())

  notFound: ->
    mkm.helpers.flash('warning', "I could not find the page you asked for, the link may be broken :/")
    @navigate("", true)

  showArticle: (id) ->
    if article = @_getArticle(id)
      @swap(new mkm.views.articles.ShowArticleView({model: article}))

  editArticle: (id) ->
    if article = @_getArticle(id)
      @swap(new mkm.views.articles.EditArticleView({model: article}))

  showPhoto: (aId, pId) ->
    if article = @_getArticle(aId)
      if photo = @_getPhoto(article, pId, "articles/#{article.id}")
        @swap(new mkm.views.articles.ShowArticleView({model: article, displayPhoto: photo}))

  editPhoto: (aId, pId) ->
    if article = @_getArticle(aId)
      if photo = @_getPhoto(article, pId, "articles/#{article.id}")
        @swap(new mkm.views.photos.EditPhotoView({model: photo}))

  newArticle: ->
    @swap(new mkm.views.articles.EditArticleView({model: new mkm.models.Article()}))

  newPhoto: (aId) ->
    if article = @_getArticle(aId)
      @swap(new mkm.views.photos.NewPhotoView({model: model}))

  newCountry: ->
    @swap(new mkm.views.countries.EditCountryView({model: new mkm.models.Country()}))

  editCountry: (id) ->
    if country = @_getCountry(id)
      @swap(new mkm.views.countries.EditCountryView({model: country}))

  swap: (newView) ->
    mkm.helpers.flash('clear')
    @view.leave() if @view?.leave
    @view.destroy() if @view
    @view = newView
    $("#page-content").html(@view.render().el).hide().fadeIn(600)
    @view.init() if @view.init
    $('#menu').html(new mkm.views.TopBarView().render().el)



  _getModel: (key, id, fallback) ->
    if model = mkm.collections[key].get(id)
      return model
    else
      mkm.helpers.flash('error', "No such #{key.replace(/s$/, "")}")
      @navigate(fallback, true)

  _getArticle: (id, fallback = '') ->
    @_getModel('articles', id, fallback)

  _getPhoto: (article, pId, fallback = '') ->
    if photo = article.get('photos').get(pId)
      return photo
    else
      mkm.helpers.flash('error', "No such photo")
      @navigate(fallback, true)

  _getCountry: (id, fallback = '') ->
    @_getModel('countries', id, fallback)



Backbone.View::destroy = ->
  # Destroy sub views
  if @views
    for view in @views
      view.destroy()
    @views.length = 0
  
  # Perform internal view cleanup
  @leave() if @leave

  # Remove the view from the DOM.
  # This will also remove events bound to the view's private DOM-element (@el)
  @remove()
