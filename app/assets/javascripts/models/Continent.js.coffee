class mkm.models.Continent extends Backbone.Model
  url: "/continents"

  countries: ->
    mkm.collections.countries.filter((country) => country.get('continent_id') is @get('id'))

  hasArticles: ->
    _.any(@countries(), (country) -> console.log(country.articles().length); country.articles().length > 0)

