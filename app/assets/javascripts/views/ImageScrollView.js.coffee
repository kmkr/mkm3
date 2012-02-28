class mkm.views.ImageScrollView extends Backbone.View
  template: JST['page/imagescroll']

  # whether or not the images should link to the article
  link: false

  initialize: (opts = {}) ->
    @link = opts.link if opts.link

  init: ->
    @$('.nivoSlider').nivoSlider({
      effect: 'boxRandom'
      randomStart: true
      pauseTime: 8000
      captionOpacity: 0.7
    })

  render: ->
    if @collection.length isnt 0
      $(@el).html(@template({photos: @collection, link: @link}))
    @
