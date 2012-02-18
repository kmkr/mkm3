class mkm.views.articles.ShowArticleView extends Backbone.View
  template: JST['articles/show']
  className: 'showArticleView'
  views: []

  events: ->
    "click .confirm"        : mkm.helpers.confirm.dialog
    "click .delete-article" : "del"
    "click .publish"        : "publish"
    "click .unpublish"      : "unpublish"

  del: (evt) =>
    evt.preventDefault()
    button = $(evt.target).closest('.btn')
    button.after($('<img src="/assets/loader.gif" />'))
    button.remove()
    @model.destroy({success: ->
      mkm.helpers.flash('info', "Article removed")
      mkm.routers.router.navigate("", true)
    })
    
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
        @render()
    })

  initialize: ->
    _.extend(@, new mkm.helpers.ArticleMapHelper())

  init: ->
    @initMap({ readOnly: true })

  writePublishStatus: ->
    @$('.publish-info').html("Published #{$.timeago(@model.get('published'))}.")

  render: ->
    $(@el).html(@template({article: @model}))
    thumbnailPhotoView = new mkm.views.photos.ThumbnailsPhotoView({ model: @model})
    @views.push(thumbnailPhotoView)
    $(@el).find('.photos').html(thumbnailPhotoView.render().el)
    @writePublishStatus() if @model.published()
    @
