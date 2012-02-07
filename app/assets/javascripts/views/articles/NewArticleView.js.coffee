class mkm.views.articles.NewArticleView extends Backbone.View
  template: JST['articles/new']

  events:
    "click button"    : "save"

  save: (evt) ->
    evt.preventDefault()
    article = new mkm.models.Article({
      title: $(@el).find('#title').val()
      start_date: $(@el).find('#start-date').val()
      end_date: $(@el).find('#end-date').val()
      country_id: $(@el).find('#country option:selected').val()
      body: $(@el).find('#article-body').val()
    })

    article.save({}, {
      success: =>
        mkm.collections.articles.add(article)
        mkm.helpers.flash('info', "Article added successfully")
      error: (model, resp) =>
        mkm.helpers.flash('error', "Unable to add article (#{resp.statusText})")
    })



  renderCountries: ->
    mkm.collections.countries.forEach((country) =>
      ctr = $('<option>').attr('value', country.id)
      $(@el).find("#country").append(ctr)
    )


  render: ->
    $(@el).html(@template)
    @renderCountries()
    $(@el).find('[data-datepicker]').datepicker()
    settings = new mkm.helpers.TextileHelper().settings
    $(@el).find("#article-body").markItUp(settings)
    @
