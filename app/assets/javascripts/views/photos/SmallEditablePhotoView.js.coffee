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
        console.log(@model.get('caption'))
        console.log(@model)
        @$('.loader').hide()
        @$('.update-photo').show()
    })

  render: ->
    $(@el).html(@template({ model: @model }))
    @
