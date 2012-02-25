class mkm.views.countries.EditCountryView extends Backbone.View
  template: JST['countries/edit']
  className: 'editCountry'

  initialize: ->
    _.extend(@, new mkm.helpers.ArticleMapHelper())

  events:
    "click button"    : "save"

  save: (evt) ->
    evt.preventDefault()
    @model.save({
      title: $(@el).find('#title').val()
      continent_id: $(@el).find('#continent option:selected').val()
    },
    {
      success: =>
        mkm.collections.countries.add(@model) unless mkm.collections.countries.any((country) -> @model.id == country.id)
        mkm.helpers.flash('info', "Country successfully saved")
        mkm.routers.router.navigate("countries/new", true)
      error: (model, resp) =>
        mkm.helpers.flash('error', "Unable to save country (#{resp.statusText})")
    })

  renderContinents: ->
    mkm.collections.continents.forEach((continent) =>
      cont = $('<option>').attr('value', continent.id).text(continent.get('title'))
      cont.attr('selected', 'selected') if @model.get('continent_id') == continent.id
      $(@el).find("#continent").append(cont)
    )

  init: ->
    @initMap()
    @on('map:clicked', (resp) =>
      @removeMarker()
      @model.set({latitude: resp.latitude, longitude: resp.longitude })
    )

  render: ->
    $(@el).html(@template({country: @model}))
    @renderContinents()
    @
