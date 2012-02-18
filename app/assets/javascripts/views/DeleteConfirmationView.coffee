class mkm.views.DeleteConfirmationView extends Backbone.View
  template: JST['page/deleteconfirmation']

  initialize: (opts) ->
    @element = opts.element

  open: ->
    @element.data('propagationStopped', true)
    @$(".delete-modal").modal()

  events:
    "click .delete-ok"      : "del"
    "click .delete-no"      : "cancel"

  del: (e) =>
    @$('.delete-modal').modal('hide')
    
    @remove()
    @element.trigger('click')

  cancel: (e) =>
    @$('.delete-modal').modal('hide')
    
    @remove()
    @element.data('propagationStopped', false)

  render: =>
    $(@el).html(@template)
    @
