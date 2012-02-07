window.module = (name, fn)->
  if not @[name]?
    this[name] = {}
  if not @[name].module?
    @[name].module = window.module
  fn.apply(this[name], [])

@module "mkm", ->
  @init = ->
    new mkm.routers.AppRouter()
    $.get("/articles", (articles) ->
      mkm.collections.articles = new mkm.collections.ArticleCollection(articles)
      Backbone.history.start()
    )
  @module "views", ->
  @module "collections", ->
  @module "models", ->
  @module "routers", ->
  @module "mixins", ->
  @module "helpers", ->

$(->
  $('.dropdown-toggle').dropdown()
  $('.alert-message').alert()
)
