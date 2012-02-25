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
      $(@).find('> ul').slideDown(100)
    ).mouseleave(->
      timeout = setTimeout(=>
        $(@).find('> ul').slideUp(50)
      , 100)
      $(@).data('timeout', timeout)
    )

    @$('ul li ul').mouseenter(->
      $(@).find('> ul').slideDown(100)
    ).mouseleave(->
      $(@).find('> ul').slideUp(50))

  render: =>
    $(@el).html(@template({
      countries: mkm.collections.countries.models
      continents: mkm.collections.continents.models
      articles: mkm.collections.articles.models
    }))
    @renderMenu()
    @
