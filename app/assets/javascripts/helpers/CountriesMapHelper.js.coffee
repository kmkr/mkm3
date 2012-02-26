class mkm.helpers.CountriesMapHelper extends mkm.helpers.AbstractMapHelper
  placeMarkers: ->
    mkm.collections.articles.each((article) =>
      position = new google.maps.LatLng(article.get('latitude'), article.get('longitude'))
      @placeMarker(position, article.get('title'))
    )

  renderMap: ->
    super({
      zoom: 1
      disableDefaultUI: true
    })

  initMap: ->
    super
    @placeMarkers()
