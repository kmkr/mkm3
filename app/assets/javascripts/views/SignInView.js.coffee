class mkm.views.SignInView extends Backbone.View
  template: JST['page/signin']

  render: ->
    @$el.html(@template)
    @
