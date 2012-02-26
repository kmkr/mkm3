class mkm.views.photos.SmallEditablePhotoView extends Backbone.View
  template: JST['photos/smalledit']

  events:
    "click .update-photo"     : "update"

  update: (e) =>
    e.preventDefault()
    @$('.loader').show()
    @$('.update-photo').hide()
    @model.save({
      caption: @$('[name=caption]').val()
      widescreenCaption: @$('[name=widescreenCaption]').val()
      useAsArticleImage: @$('[name=useAsArticleImage]').is(':checked')
    }, {
      success: =>
        mkm.helpers.flash('info' ,"Successfully updated photo")
        @$('.loader').hide()
        @$('.update-photo').show()
      error: ->
        mkm.helpers.flash('error', "Error while updating photo.")
        @$('.loader').hide()
        @$('.update-photo').show()
    })

  render: ->
    $(@el).html(@template({ model: @model }))
    @$('a[rel=tooltip]').tooltip()
    @
