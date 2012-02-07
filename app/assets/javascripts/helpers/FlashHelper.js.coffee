mkm.helpers.flash = (level, message) ->
  $('#alerts').html(JST['alert']({level: level, message: message }))
  $('#alerts').find('alert').alert()
