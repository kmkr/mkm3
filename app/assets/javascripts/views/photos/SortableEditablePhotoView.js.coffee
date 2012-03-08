class mkm.views.photos.SortableEditablePhotoView extends Backbone.View
  template: JST['photos/sortableeditablephoto']
  views: []
  className: 'sortableEditablePhoto'

  initialize: ->
    @model.on('change', @updatePos)

  leave: ->
    @model.off('change', @updatePos)

  updatePos: =>
    console.log "position update: %s, setter på %o", @model.get('position'), @$('.position')
    @$('.position').text(@model.get('position'))

  renderEditablePhoto: ->
    v = new mkm.views.photos.SmallEditablePhotoView({model: @model})
    @views.push(v)
    @$('.small-editable-photo').html(v.render().el)

  render: ->
    $(@el).html(@template({model: @model}))
    @renderEditablePhoto()
    @
