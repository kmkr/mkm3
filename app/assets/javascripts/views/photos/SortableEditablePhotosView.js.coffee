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
    @collection.forEach((photo) =>
      photo.save({},
        success: =>
          @$('.bar').width("#{(++completed / total) * 100}%")
          @collection.sort()
          if completed is total
            mkm.helpers.flash('info', 'Positions updated successfully')
            @$('.save-all-wrapper').hide('fade', -> $(@).width('0'))

        error: ->
          mkm.helpers.flash('error', 'Problems when updating position. Please do a page refresh and retry.')
      )
    )

  renderPhotos: ->
    @collection.forEach((photo) =>
      v = new mkm.views.photos.SmallEditablePhotoView({model: photo})
      @views.push(v)
      @$('.photos').append(v.render().el)
    )

  removeRow: (photo) =>
    item = @$("[data-photo-id=#{photo.id}]")
    item.hide('fade', =>
      item.remove()
      @updatePosition()
    )

  updatePosition: =>
    currentPos = 1
    @$('.smallEditablePhoto > div').each((i, elem) =>
      id = Number($(elem).attr('data-photo-id'))
      # The item can have been deleted
      if item = @collection.get(id)
        item.set({position: currentPos++})
    )
    @$('.save-all-wrapper').show().effect('highlight')
    

  makeSortable: ->
    @$('.photos').sortable({opacity: 0.8}).bind('sortupdate', @updatePosition)

  render: ->
    $(@el).html(@template)
    @renderPhotos()
    @makeSortable()
    @
