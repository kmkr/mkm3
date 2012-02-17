class mkm.helpers.CountriesMapHelper extends mkm.helpers.AbstractMapHelper
  placeMarkers: ->
    mkm.collections.countries.each((country) =>
      position = new google.maps.LatLng(country.get('latitude'), country.get('longitude'))
      @placeMarker(position)
    )

  initMap: ->
    super
    @placeMarkers()
