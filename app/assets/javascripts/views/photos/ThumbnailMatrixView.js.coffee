class mkm.views.photos.ThumbnailMatrixView extends Backbone.View
  template: JST['photos/thumbnailmatrix']
  className: 'thumbnailMatrixView'
  views: []

  initialize: (opts = {}) ->
    @collection.bind('remove', @render)

  createPage: ->
    p = $('<div>')
    ul = $('<ul>').addClass('thumbnails')
    p.append(ul)
    p

  leave: ->
    @collection.unbind('remove', @render)

  render: =>
    $(@el).html(@template)

    page = @createPage()
    @collection.forEach((photo, index) =>
      t = new mkm.views.photos.ThumbnailPhotoView({model: photo, size: 'small'})
      page.find('ul').append($(t.render().el).addClass('span3'))
      @views.push(t)
    )
    @$('.gallery').append(page)

    @
