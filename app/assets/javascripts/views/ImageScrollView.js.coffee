class mkm.views.ImageScrollView extends Backbone.View
  template: JST['page/imagescroll']

  # whether or not the images should link to the article
  link: false
  captionType: 'caption'

  initialize: (opts = {}) ->
    @link = opts.link if opts.link
    @captionType = opts.captionType if opts.captionType
    @nivoExtensions = opts.nivoExtensions

  init: ->
    opts = _.extend({
      effect: 'boxRandom'
      randomStart: true
      pauseTime: 14000
      captionOpacity: 0.7
      pauseOnHover: false
    }, @nivoExtensions)
    @$('.nivoSlider').nivoSlider(opts)

  render: ->
    if @collection.length isnt 0
      $(@el).html(@template({photos: @collection, link: @link, captionType: @captionType}))
    @
