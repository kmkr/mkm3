class mkm.views.photos.SmallEditablePhotoView extends Backbone.View
  template: JST['photos/smalledit']

  className: 'smallEditablePhoto span3'

  initialize: ->
    @model.on('destroy', @hide)
    @model.on('change', @updatePos)

  leave: ->
    @model.off('destroy', @hide)
    @model.off('change', @updatePos)

  events:
    "click .update-photo"     : "update"
    "click .delete-photo"     : "delete"

  updatePos: =>
    @$('.position').text(@model.get('position'))


  hide: =>
    $(@el).hide('slow')

  toggleLoad: ->
    @$('.loader').toggle()
    @$('button').toggle()

  update: (e) =>
    e.preventDefault()
    @toggleLoad()
    @model.save({
      caption: @$('[name=caption]').val()
      widescreenCaption: @$('[name=widescreenCaption]').val()
      useAsArticlePhoto: @$('[name=useAsArticlePhoto]').is(':checked')
      useAsFrontpagePhoto: @$('[name=useAsFrontpagePhoto]').is(':checked')
    }, {
      success: =>
        mkm.helpers.flash('info' ,"Successfully updated photo")
        @toggleLoad()
      error: =>
        mkm.helpers.flash('error', "Error while updating photo.")
        @toggleLoad()
    })

  delete: (e) =>
    e.preventDefault()
    @toggleLoad()
    @model.destroy({
      wait: true
      success: =>
        mkm.helpers.flash('info' ,"Successfully deleted photo")
        @toggleLoad()
      error: =>
        mkm.helpers.flash('error', "Unable to delete photo.")
        @toggleLoad()
    })

  render: ->
    $(@el).html(@template({ model: @model }))
    @
