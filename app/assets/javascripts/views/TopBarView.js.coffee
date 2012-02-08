class mkm.views.TopBarView extends Backbone.View
  template: JST['page/topbar']

  initialize: ->
    mkm.collections.countries.on('add remove', @render)
    mkm.collections.continents.on('add remove', @render)
    mkm.collections.articles.on('add remove', @render)

  render: =>
    $(@el).html(@template({
      countries: mkm.collections.countries.models
      continents: mkm.collections.continents.models
      articles: mkm.collections.articles.models
    }))
    $(@el).find('.sf-menu').superfish()
    @
