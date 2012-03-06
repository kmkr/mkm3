class mkm.views.photos.SortableEditablePhotosView extends Backbone.View
  template: JST['photos/sortableeditablephotos']
  views: []
  className: 'sortableEditablePhotos'

  events:
    "click .save-position"        : "saveUpdated"

  saveUpdated: ->
    @collection.forEach((photo) ->
      photo.save()
    )

  renderPhotos: ->
    @collection.forEach((photo, index) =>
      v = new mkm.views.photos.SmallEditablePhotoView({model: photo})
      @views.push(v)
      d = $('<div>').addClass('row sortableElement').attr('data-photo-id', photo.id)
      spanPosit = $('<div>').addClass('span3 position').html("<p>#{index+1}</p>")
      spanPhoto = $('<div>').addClass('span9')
      spanPhoto.append(v.render().el)
      d.append(spanPosit)
      d.append(spanPhoto)
      @$('.photos').append(d)
    )

  # todo: consider listening for changes on model directly
  # will perhaps require one additional level of views
  updatePosition: =>
    @$('.sortableElement').each((i, elem) =>
      id = $(elem).attr('data-photo-id')
      $(elem).find('.position p').text(i+1)
      $(elem).effect('highlight')
      @collection.get(id).set({position: i+1})
      p = @collection.get(id)
    )
    

  makeSortable: ->
    $(@el).sortable().bind('sortupdate', @updatePosition)

  render: ->
    $(@el).html(@template)
    @renderPhotos()
    @makeSortable()
    @
