class mkm.views.IndexView extends Backbone.View

  initialize: ->
    _.extend(@, new mkm.helpers.CountriesMapHelper())

  init: ->
    @initMap({ readOnly: true})

  template: JST['page/index']

  render: ->
    $(@el).html(@template)
    @
