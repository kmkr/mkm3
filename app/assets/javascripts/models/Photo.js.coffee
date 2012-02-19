class mkm.models.Photo extends Backbone.RelationalModel
  urlRoot: ->
    "/articles/#{@get('article_id')}/photos"

  isCropped: ->
    if @get('crop_x') then true else false

  cropped: ->
    [ @get('crop_x')
      @get('crop_y')
      @get('crop_x') + @get('crop_w')
      @get('crop_y') + @get('crop_h')
    ]
