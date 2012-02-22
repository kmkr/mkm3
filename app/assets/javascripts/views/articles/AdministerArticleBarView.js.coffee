class mkm.views.articles.AdministerArticleBarView extends Backbone.View
  template: JST['articles/administerbar']

  initialize: ->
    @model.bind('destroy', ->
      mkm.helpers.flash('info', "Article removed")
      mkm.routers.router.navigate("", true)
    )

    @model.bind('change:published', @render)

  leave: ->
    @model.unbind('change:published', @render)
    @model.unbind('destroy')

  events:
    "click .confirm"        : mkm.helpers.confirm.dialog
    "click .delete-article" : "del"
    "click .publish"        : "publish"
    "click .unpublish"      : "unpublish"

  del: (evt) =>
    evt.preventDefault()
    button = $(evt.target).closest('.btn')
    @$('.loader').show()
    button.remove()
    @model.destroy({wait: true})

  unpublish: (evt) =>
    evt.preventDefault()
    @model.save({
      published: ""
    }, {
      success: =>
        mkm.helpers.flash('info', 'Article is now hidden')
        @render()
    })

  publish: (evt) =>
    evt.preventDefault()

    @model.save({
      published: new Date()
    }, {
      success: =>
        mkm.helpers.flash('info', 'Article is published')
      wait: true
    })

  render: =>
    $(@el).html(@template({article: @model}))
    @
