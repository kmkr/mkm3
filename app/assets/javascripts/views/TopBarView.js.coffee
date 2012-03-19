class mkm.views.TopBarView extends Backbone.View
  template: JST['page/topbar']
  className: 'view-topbar'
  timeout: null

  initialize: ->
    mkm.collections.countries.on('add remove', @render)
    mkm.collections.continents.on('add remove', @render)
    mkm.collections.articles.on('add remove', @render)

  renderMenu: ->
    @$('ul:nth-child(1) > li').mouseenter(->
      clearTimeout($(@).data('timeout')) if $(@).data('timeout')
      $(@).addClass('active').find('> ul').slideDown(120)
    ).mouseleave(->
      timeout = setTimeout(=>
        $(@).removeClass('active').find('> ul').slideUp(90)
      , 140)
      $(@).data('timeout', timeout)
    )

    
    @$('ul > li > ul > li').mouseenter(->
      clearTimeout($(@).data('timeout')) if $(@).data('timeout')
      $(@).addClass('active').find('> ul').fadeIn(160))
      .mouseleave(->
        timeout = setTimeout(=>
          $(@).removeClass('active').find('> ul').fadeOut(120)
        , 100)
        $(@).data('timeout', timeout)
      )

  addClickListeners: ->
    @$('li li li').each(->
      link = $(@).find('a').attr('href')
      $(@).click(-> mkm.routers.router.navigate(link, true)))

  render: =>
    $(@el).html(@template({
      continents: mkm.collections.continents
    }))
    @renderMenu()
    @addClickListeners()
    @
