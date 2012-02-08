class mkm.helpers.MapHelper
  constructor: ->
    _.extend(@, Backbone.Events)

  renderMap: ->
    mapOpts =
      center: new google.maps.LatLng(0, 0)
      mapTypeId: google.maps.MapTypeId.TERRAIN
      zoom: 1
    @map = new google.maps.Map(document.getElementById("map"), mapOpts)

  removeMarker: ->
    @marker.setMap(null) if @marker

  placeMarker: (position) ->
    @removeMarker()
    @marker = new google.maps.Marker({
      position: position
      map: @map
    })
    @map.setCenter(position)

  addClickListener: ->
    google.maps.event.addListener(@map, 'click', (evt) =>
      @trigger('map:clicked', { latitude: evt.latLng.lat(), longitude: evt.latLng.lng() })
      @placeMarker(evt.latLng)
    )

  initMap: ->
    @renderMap()
    @addClickListener()
