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
      t = new mkm.views.photos.ThumbnailPhotoView({model: photo, size: 'medium'})
      page.find('ul').append($(t.render().el))
      @views.push(t)
    )
    @$('.gallery').append(page)

    @
