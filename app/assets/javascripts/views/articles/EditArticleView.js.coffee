class mkm.views.articles.EditArticleView extends Backbone.View
  template: JST['articles/edit']

  initialize: ->
    _.extend(@, new mkm.helpers.ArticleMapHelper())

  events:
    "click button"    : "save"

  save: (evt) ->
    evt.preventDefault()
    @model.save({
      title: $(@el).find('#title').val()
      start_date: $(@el).find('#startDate').val()
      end_date: $(@el).find('#endDate').val()
      country_id: $(@el).find('#country option:selected').val()
      body: $(@el).find('#article-body').val()
    }, {
      success: =>
        mkm.collections.articles.add(@model) unless mkm.collections.articles.any((article) => @model.id == article.id)
        mkm.helpers.flash('info', "Article successfully saved")
        mkm.routers.router.navigate("articles/#{@model.id}", true)
      error: (model, resp) =>
        mkm.helpers.flash('error', "Unable to save article (#{resp.statusText})")
    })

  renderCountries: ->
    mkm.collections.countries.forEach((country) =>
      ctr = $('<option>').attr('value', country.id).text(country.get('title'))
      ctr.attr('selected', 'selected') if @model.get('country_id') == country.id
      $(@el).find("#country").append(ctr)
    )

  init: ->
    @initMap()
    @on('map:clicked', (resp) =>
      @model.set({ latitude: resp.latitude, longitude: resp.longitude })
    )
    @on('map:zoom', (resp) =>
      @model.set({ zoom_level: resp.zoomLevel })
    )

  render: ->
    $(@el).html(@template({article: @model}))
    @renderCountries()
    $(@el).find('[data-datepicker]').datepicker()
    settings = new mkm.helpers.TextileHelper().settings
    $(@el).find("#article-body").markItUp(settings)
    @
