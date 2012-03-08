class mkm.views.photos.SortableEditablePhotosView extends Backbone.View
  template: JST['photos/sortableeditablephotos']
  views: []
  className: 'sortableEditablePhotos'

  events:
    "click .save-position"        : "saveUpdated"

  initialize: ->
    @collection.on('remove', @removeRow)

  leave: ->
    @collection.off('remove', @removeRow)

  saveUpdated: ->
    total = @collection.length
    completed = 0
    @collection.forEach((photo) ->
      photo.save({},
        success: =>
          @$('.bar').width("#{(++completed / total) * 100}%")
          if completed is total
            @$('.save-all-wrapper').hide('fade', -> $(@).width('0'))
      )
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

  removeRow: (photo) =>
    item = @$("[data-photo-id=#{photo.id}]")
    item.hide('fade', =>
      item.remove()
      @updatePosition()
    )

  # todo: consider listening for changes on model directly
  # will perhaps require one additional level of views
  updatePosition: =>
    currentPos = 0
    @$('.sortableElement').each((i, elem) =>
      id = $(elem).attr('data-photo-id')
      $(elem).find('.position p').text(i+1)
      # The item can have been deleted
      if item = @collection.get(id)
        item.set({position: currentPos++})
    )
    @$('.save-all-wrapper').show().effect('highlight')
    

  makeSortable: ->
    @$('.photos').sortable().bind('sortupdate', @updatePosition)

  render: ->
    $(@el).html(@template)
    @renderPhotos()
    @makeSortable()
    @
