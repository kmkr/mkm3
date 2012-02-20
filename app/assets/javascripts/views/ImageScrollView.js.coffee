class mkm.views.ImageScrollView extends Backbone.View
  template: JST['page/imagescroll']

  init: ->
    @$('.nivoSlider').nivoSlider({
      effect: 'boxRandom'
      randomStart: true
      pauseTime: 8000
    })

  render: ->
    $(@el).html(@template({collection: @collection}))
    @
