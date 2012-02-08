window.module = (name, fn)->
  if not @[name]?
    this[name] = {}
  if not @[name].module?
    @[name].module = window.module
  fn.apply(this[name], [])

@module "mkm", ->
  @module "views", ->
    @module "articles", ->
    @module "countries", ->
  @module "collections", ->
  @module "models", ->
  @module "routers", ->
  @module "mixins", ->
  @module "helpers", ->

$(->
  $('.dropdown-toggle').dropdown()
  $('.alert-message').alert()
)
