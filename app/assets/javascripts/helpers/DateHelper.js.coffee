mkm.helpers.date =
  monthNames: [ "January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December" ]
  format: (input) ->
    if input and match = input.match(/(\d{4})-(\d{2})-(\d{2})/)
      year = Number(match[1])
      month = @monthNames[Number(match[2])-1]

      return "#{month} #{year}"
