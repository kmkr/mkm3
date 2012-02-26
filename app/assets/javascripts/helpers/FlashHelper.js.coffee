mkm.helpers.flash = (level, message) ->
  if level is "clear"
    $('#alerts').html('')
  else
    $('#alerts').html(JST['alert']({level: level, message: message }))
    $('#alerts').find('alert').alert()

