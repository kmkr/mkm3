class mkm.views.articles.EditArticleView extends Backbone.View
  template: JST['articles/edit']
  className: 'editArticleView'
  views: []

  initialize: ->
    _.extend(@, new mkm.helpers.ArticleMapHelper(
      {
        draggable: true
        scrollwheel: true
      }
    ))

  events:
    "click .save-article"    : "save"

  save: (evt) ->
    evt.preventDefault()
    @$('.save-article').attr('disabled', 'disabled')
    @$('.loader').show()
    @model.save({
      title: @$('#title').val()
      start_date: @$('#startDate').val()
      end_date: @$('#endDate').val()
      country_id: Number(@$('#country option:selected').val())
      body: @$('#article-body').val()
      published: @$('#published').val()
    }, {
      success: =>
        mkm.collections.articles.add(@model) unless mkm.collections.articles.any((article) => @model.id == article.id)
        mkm.helpers.flash('success', "Article successfully saved")
        mkm.routers.router.navigate("articles/#{@model.id}", true)
      error: (model, resp) =>
        @$('.save-article').removeAttr('disabled')
        @$('.loader').hide()
        mkm.helpers.flash('error', "Unable to save article (#{resp.statusText})")
    })

  renderCountries: ->
    mkm.collections.countries.forEach((country) =>
      ctr = $('<option>').attr('value', country.id).text(country.get('title'))
      ctr.attr('selected', 'selected') if @model.get('country_id') == country.id
      @$("#country").append(ctr)
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
    @$('[data-datepicker]').datepicker()
    settings = new mkm.helpers.TextileHelper().settings
    @$("#article-body").markItUp(settings)
    @
