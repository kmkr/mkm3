class mkm.views.ImageScrollView extends Backbone.View
  template: JST['page/imagescroll']

  initialize: ->
    @photos = @getPhotos()

  getPhotos: ->
    photos = []
    galleries = mkm.collections.photos
    for gallery in galleries
      if gallery.length isnt 0
        for p in gallery
          photos.push(p.photo)

    console.log photos
    photos

  init: ->
    @$('.nivoSlider').nivoSlider()

  render: ->
    $(@el).html(@template({photos: @photos}))
    @
