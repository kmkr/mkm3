class mkm.views.SignInView extends Backbone.View
  template: JST['page/signin']

  render: ->
    @$el.html(@template)
    @$('input[name=authenticity_token]').attr('value', $('meta[name=csrf-token]').attr('content'))
    @
