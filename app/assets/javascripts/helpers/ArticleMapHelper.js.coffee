class mkm.helpers.ArticleMapHelper extends mkm.helpers.AbstractMapHelper
  settings: {}

  constructor: (overrides = {}) ->
    _.extend(@settings, overrides)

  renderMap: ->
    super _.extend({
      center: @getCenter()
      zoom: @getZoomLevel()
      scrollwheel: false
      draggable: false
    }, @settings)

  getZoomLevel: ->
    @model.get('zoom_level') or 1

  getCenter: ->
    lat = @model.get('latitude') or 0
    lon = @model.get('longitude') or 0
    new google.maps.LatLng(lat, lon)

  placeMarkerFromModel: ->
    @removeMarker()
    position = new google.maps.LatLng(@model.get('latitude'), @model.get('longitude'))
    @placeMarker(position)

  initMap: ->
    super
    @placeMarkerFromModel() if @model.get('latitude') and @model.get('longitude')
