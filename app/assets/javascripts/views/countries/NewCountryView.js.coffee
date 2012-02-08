class mkm.views.countries.NewCountryView extends Backbone.View
  template: JST['countries/new']

  initialize: ->
    _.extend(@, new mkm.helpers.MapHelper())

  events:
    "click button"    : "save"

  save: (evt) ->
    evt.preventDefault()
    country = new mkm.models.Country({
      title: $(@el).find('#title').val()
      continent_id: $(@el).find('#continent option:selected').val()
      latitude: $(@el).find('input[name=latitude]').val()
      longitude: $(@el).find('input[name=longitude]').val()
    })

    country.save({}, {
      success: =>
        mkm.collections.countries.add(country)
        mkm.helpers.flash('info', "Country added successfully")
        mkm.routers.router.navigate("country/#{country.id}", true)
      error: (model, resp) =>
        mkm.helpers.flash('error', "Unable to add country (#{resp.statusText})")
    })

  renderContinents: ->
    mkm.collections.continents.forEach((continent) =>
      cont = $('<option>').attr('value', continent.id).text(continent.get('title'))
      $(@el).find("#continent").append(cont)
    )

  init: ->
    @initMap()
    @on('map:clicked', (resp) =>
      $(@el).find('input[name=latitude]').val(resp.latitude)
      $(@el).find('input[name=longitude]').val(resp.longitude)
    )

  render: ->
    $(@el).html(@template)
    @renderContinents()
    @
