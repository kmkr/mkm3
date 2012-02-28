class mkm.views.photos.SmallEditablePhotoView extends Backbone.View
  template: JST['photos/smalledit']

  initialize: ->
    @model.on('destroy', @hide)

  leave: ->
    @model.off('destroy', @hide)

  events:
    "click .update-photo"     : "update"
    "click .delete-photo"     : "delete"

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
      useAsFrontPagePhoto: @$('[name=useAsArticlePhoto]').is(':checked')
    }, {
      success: =>
        mkm.helpers.flash('info' ,"Successfully updated photo")
        @toggleLoad()
      error: ->
        mkm.helpers.flash('error', "Error while updating photo.")
        @toggleLoad()
    })

  delete: (e) =>
    e.preventDefault()
    @toggleLoad()
    @model.destroy({
      success: =>
        mkm.helpers.flash('info' ,"Successfully deleted photo")
        @toggleLoad()
      error: =>
        mkm.helpers.flash('error', "Unable to delete photo.")
        @toggleLoad()
    })

  render: ->
    $(@el).html(@template({ model: @model }))
    @$('a[rel=tooltip]').tooltip()
    @
