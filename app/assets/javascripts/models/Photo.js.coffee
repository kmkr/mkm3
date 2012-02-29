class mkm.models.Photo extends Backbone.RelationalModel
  urlRoot: ->
    "/articles/#{@get('article_id')}/photos"

  isCropped: ->
    _.isNumber(@get('crop_x'))

  cropped: ->
    [ @get('crop_x')
      @get('crop_y')
      @get('crop_x') + @get('crop_w')
      @get('crop_y') + @get('crop_h')
    ]
