class mkm.views.IndexView extends Backbone.View
  template: JST['page/index']
  views: []

  initialize: ->
    _.extend(@, new mkm.helpers.CountriesMapHelper())

  init: ->
    @initMap({ readOnly: true})
    @imgsc.init()
    @carousel.init()

  render: ->
    $(@el).html(@template)
    @imgsc = new mkm.views.ImageScrollView()
    @views.push(@imgsc)
    @carousel = new mkm.views.CarouselView()
    @views.push(@carousel)
    @$('.imagescroll').html(@imgsc.render().el)
    @$('.carousel').html(@carousel.render().el)
    @
