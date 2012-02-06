class mkm.views.IndexView extends Backbone.View
  template: JST['page/index']

  render: ->
    $(@el).html(@template)
    @
