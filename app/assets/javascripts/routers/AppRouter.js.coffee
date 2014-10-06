class mkm.routers.AppRouter extends Backbone.Router

  routes:
    ""                        : "index"
    "articles/new"            : "newArticle"
    "articles/:id/photos/new" : "newPhoto"
    "articles/:id/photos/edit": "editPhotos"
    "articles/:aId/photos/:pId/edit": "editPhoto"
    "articles/:aId/photos/:pId": "showPhoto"
    "articles/:id/edit"       : "editArticle"
    "articles/:id"            : "showArticle"
    "countries/:id/edit"      : "editCountry"
    "countries/new"           : "newCountry"
    "countries"               : "showCountries"
    "users/sign_in"           : "signIn"
    "*path"                   : "notFound"

  index: ->
    @swap(new mkm.views.IndexView())

  notFound: ->
    @navigate("", true)
    mkm.helpers.flash('warning', "I couldn't find the page you asked for, the link might be broken :/")

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

  editPhotos: (id) ->
    if article = @_getArticle(id)
      @swap(new mkm.views.photos.SortableEditablePhotosView({collection: article.get('photos')}))

  newArticle: ->
    @swap(new mkm.views.articles.EditArticleView({model: new mkm.models.Article()}))

  newPhoto: (aId) ->
    if article = @_getArticle(aId)
      @swap(new mkm.views.photos.NewPhotoView({model: article}))

  newCountry: ->
    @swap(new mkm.views.countries.EditCountryView({model: new mkm.models.Country()}))

  editCountry: (id) ->
    if country = @_getCountry(id)
      @swap(new mkm.views.countries.EditCountryView({model: country}))

  showCountries: ->
    @swap(new mkm.views.countries.IndexCountriesView({collection: mkm.collections.countries}))

  signIn: ->
    @swap(new mkm.views.SignInView())

  swap: (newView) ->
    mkm.helpers.flash('clear')
    @view.leave() if @view?.leave
    @view.destroy() if @view
    @view = newView
    $("#page-content").html(@view.render().el).hide().fadeIn(600)
    @view.init() if @view.init
    document.title = @_getTitleFromView(@view)
    $('html, body').animate({scrollTop: 0}, 'fast')

  _getTitleFromView: (view) ->
    title = "MKM"
    title += " :: #{view.title}" if view.title
    title

  _getModel: (key, id, fallback) ->
    id = @_clean(id)
    if model = mkm.collections[key].get(id)
      return model
    else
      @navigate(fallback, true)
      mkm.helpers.flash('error', "Cannot find #{key.replace(/s$/, "")} with id '#{id}'")
      return undefined

  _getArticle: (id, fallback = '') ->
    @_getModel('articles', @_clean(id), fallback)

  _getPhoto: (article, pId, fallback = '') ->
    if photo = article.get('photos').get(@_clean(pId))
      return photo
    else
      @navigate(fallback, true)
      mkm.helpers.flash('error', "No such photo")
      return undefined

  _getCountry: (id, fallback = '') ->
    @_getModel('countries', @_clean(id), fallback)

  _clean: (param) ->
    param.replace(/\?.*/, "")


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
