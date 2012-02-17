class mkm.helpers.AbstractMapHelper
  constructor: ->
    _.extend(@, Backbone.Events)

  renderMap: (mapOpts = {}) ->
    opts = _.extend({
      center: new google.maps.LatLng(0, 0)
      zoom: 0
      mapTypeId: google.maps.MapTypeId.TERRAIN
    }, mapOpts)
    @map = new google.maps.Map(document.getElementById("map"), opts)

  removeMarker: ->
    @marker.setMap(null) if @marker

  placeMarker: (position) ->
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
