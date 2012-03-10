class mkm.views.countries.IndexCountriesView extends Backbone.View
  template: JST['countries/index']

  events:
    "click .delete-country"   : "deleteCountry"


  deleteCountry: (e) ->
    id = Number($(e.currentTarget).closest('li').attr('data-id'))

    @collection.get(id).destroy({success: @render})

  render: =>
    @$el.html(@template({countries: @collection}))
    @
