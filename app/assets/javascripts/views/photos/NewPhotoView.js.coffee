class mkm.views.photos.NewPhotoView extends Backbone.View
  template: JST['photos/new']

  filesWaiting: []
  ongoingTransfer: false

  events:
    "drop .dropArea"        : "fileDropped"
    "dragleave .dropArea"   : "dragLeave"
    "dragenter .dropArea"   : "dragEnter"
    "dragover .dropArea"    : "dragOver"

  fileDropped: (evt) =>
    evt.preventDefault()
    evt.stopPropagation()
    files = evt.originalEvent?.dataTransfer?.files
    if files
      @transferFiles(files)
    else
      mkm.helpers.flash('error', 'Your browser is too old for this')

  transferFiles: (files) ->
    parsedFiles = 0
    img = null

    for file in files
      binaryReader = new FileReader()
      binaryReader.onload = ((theImg) =>
        return (evt) =>
          imageBinary = evt.target.result
          fileName = encodeURIComponent(files[parsedFiles].fileName)
          # the image seems to be ok, send it to the server
          image = encodeURIComponent($.base64Encode(imageBinary))
          postData = "binary_data=#{image}&file_name=#{fileName}"

          parsedFiles++

          if @ongoingTransfer
            @filesWaiting.push(postData)
          else
            @ongoingTransfer = true
            @transferFile(postData)
      )(img)

      binaryReader.readAsBinaryString(file)

  transferNextFile: =>
    @transferFile(@filesWaiting.shift())

  transferFile: (postData) ->
    $.ajax({
      type: "POST"
      url: "/articles/#{@model.id}/photos"
      data: postData
      success: =>
        if @filesWaiting.length is 0
          @ongoingTransfer = false
        else
          setTimeout(@transferNextFile, 6000)
      error: (jqXhr, status, error) ->
        @filesWaiting = []
        mkm.helpers.flash('error', "Error while uploading pictures #{status} - #{error}")
    })

  dragOver: (evt) ->
    evt.preventDefault()
    evt.stopPropagation()

  dragEnter: (evt) ->
    $(evt.target).addClass('over')
    evt.preventDefault()
    evt.stopPropagation()

  dragLeave: (evt) ->
    $(evt.target).removeClass('over')
    evt.preventDefault()
    evt.stopPropagation()


  render: ->
    $(@el).html(@template({article: @model}))
    @
