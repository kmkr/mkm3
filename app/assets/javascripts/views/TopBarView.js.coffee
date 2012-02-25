class mkm.views.TopBarView extends Backbone.View
  template: JST['page/topbar']
  className: 'view-topbar'
  timeout: null

  initialize: ->
    mkm.collections.countries.on('add remove', @render)
    mkm.collections.continents.on('add remove', @render)
    mkm.collections.articles.on('add remove', @render)

  renderMenu: ->
    @$('ul li').mouseenter(->
      clearTimeout($(@).data('timeout')) if $(@).data('timeout')
      $(@).find('> ul').slideDown(120)
    ).mouseleave(->
      timeout = setTimeout(=>
        $(@).find('> ul').slideUp(90)
      , 100)
      $(@).data('timeout', timeout)
    )

    @$('ul li ul').mouseenter(->
      $(@).find('> ul').slideDown(120)
    ).mouseleave(->
      $(@).find('> ul').slideUp(90))

  render: =>
    $(@el).html(@template({
      countries: mkm.collections.countries.models
      continents: mkm.collections.continents.models
      articles: mkm.collections.articles.models
    }))
    @renderMenu()
    @
