class mkm.helpers.CountriesMapHelper extends mkm.helpers.AbstractMapHelper
  placeMarkers: ->
    mkm.collections.articles.each((article) =>
      position = new google.maps.LatLng(article.get('latitude'), article.get('longitude'))
      m = @placeMarker(position, article.escape('title'))
      @addLinkToArticleOnClick(m, article)
    )

  addLinkToArticleOnClick: (marker, article) ->
    google.maps.event.addListener(marker, 'click', (evt) ->
      mkm.routers.router.navigate("articles/#{article.id}", true)
    )

  renderMap: ->
    super({
      zoom: 1
      minZoom: 1
      disableDefaultUI: true
      zoomControl: true
    })

  initMap: ->
    super
    @placeMarkers()
    @map.setCenter(new google.maps.LatLng(17.978733, 29.179688))
