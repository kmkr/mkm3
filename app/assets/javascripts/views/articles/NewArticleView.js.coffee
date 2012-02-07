class mkm.views.articles.NewArticleView extends Backbone.View
  template: JST['articles/new']

  renderCountries: ->
    mkm.collections.countries.forEach((country) =>
      ctr = $('<option>').attr('value', country.id)
      $(@el).find("#country").append(ctr)
    )


  render: ->
    $(@el).html(@template)
    @renderCountries()
    $(@el).find('[data-datepicker]').datepicker()
    @
