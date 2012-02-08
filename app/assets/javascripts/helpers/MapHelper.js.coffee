class mkm.helpers.MapHelper
  constructor: ->
    _.extend(@, Backbone.Events)

  renderMap: ->
    mapOpts =
      center: @getCenter()
      zoom: @getZoomLevel()
      mapTypeId: google.maps.MapTypeId.TERRAIN
    @map = new google.maps.Map(document.getElementById("map"), mapOpts)

  getZoomLevel: ->
    @model.get('zoom_level') or 1

  getCenter: ->
    lat = @model.get('latitude') or 0
    lon = @model.get('longitude') or 0
    new google.maps.LatLng(lat, lon)

  removeMarker: ->
    @marker.setMap(null) if @marker

  placeMarkerFromModel: ->
    position = new google.maps.LatLng(@model.get('latitude'), @model.get('longitude'))
    @placeMarker(position)

  placeMarker: (position) ->
    @removeMarker()
    @marker = new google.maps.Marker({
      position: position
      map: @map
    })
    @map.setCenter(position)

  addListeners: ->
    google.maps.event.addListener(@map, 'click', (evt) =>
      @trigger('map:clicked', { latitude: evt.latLng.lat(), longitude: evt.latLng.lng() })
      @placeMarker(evt.latLng)
    )

    google.maps.event.addListener(@map, 'zoom_changed', (evt) =>
      @trigger('map:zoom', { zoomLevel: @map.getZoom() })
    )

  initMap: (opts = {}) ->
    @renderMap()
    @addListeners() unless opts.readOnly
    @placeMarkerFromModel() if @model.get('latitude') and @model.get('longitude')
