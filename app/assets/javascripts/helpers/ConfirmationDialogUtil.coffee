mkm.helpers.confirm =

  dialog: (event) ->
    element = $(event.currentTarget)

    # Propagation was previously stopped but re-triggered, pass the event to
    # the next handler(s)
    if element.data('propagationStopped')
      element.data('propagationStopped', false)
      return true
    else
      mkm.helpers.confirm._catchEvent(event, element)

  _catchEvent: (event, element) ->
    event.stopImmediatePropagation()
    event.preventDefault()

    dialog = new mkm.views.DeleteConfirmationView({element: element})
    $('.content').prepend(dialog.render().el)
    dialog.open()
