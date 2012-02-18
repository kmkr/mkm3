class mkm.views.IndexView extends Backbone.View
  template: JST['page/index']
  views: []
  className: 'indexView'

  initialize: ->
    _.extend(@, new mkm.helpers.CountriesMapHelper())

  init: ->
    @initMap({ readOnly: true})
    @imgsc.init()

  render: ->
    $(@el).html(@template)
    @imgsc = new mkm.views.ImageScrollView()
    @views.push(@imgsc)
    @$('.imagescroll').html(@imgsc.render().el)
    @
