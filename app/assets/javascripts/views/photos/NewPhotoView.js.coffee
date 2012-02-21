class mkm.views.photos.NewPhotoView extends Backbone.View
  template: JST['photos/new']

  className: 'newPhotoView'
  filesWaiting: []
  filesComplete: 0
  ongoingTransfer: false

  events:
    "drop .dropArea"        : "fileDropped"
    "dragleave .dropArea"   : "dragLeave"
    "dragenter .dropArea"   : "dragEnter"
    "dragover .dropArea"    : "dragOver"

  fileDropped: (evt) =>
    evt.preventDefault()
    evt.stopPropagation()

    if @ongoingTransfer
      mkm.helpers.flash('warning', 'Please wait until the current upload is complete')
      return

    files = evt.originalEvent?.dataTransfer?.files
    if files
      @transferFiles(files)
    else
      mkm.helpers.flash('error', 'Your browser is too old for this')

  transferFiles: (files) ->
    @$('.loader').show()
    @totalFiles = files.length
    parsedFiles = 0
    img = null

    @$('.progress').addClass('active')

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

  reset: ->
    @filesWaiting = []
    @filesComplete = 0
    @ongoingTransfer = false
    @$('.progress').removeClass('active')
    @$('.progress .bar').width('0')
    @$('.loader').hide()

  transferNextFile: =>
    @transferFile(@filesWaiting.shift())

  updateProgress: ->
    @filesComplete++
    @$('.progress .bar').width("#{(@filesComplete / @totalFiles) * 100}%")

    if @filesWaiting.length is 0
      mkm.helpers.flash('info', "All files uploaded successfully ")
      @reset()
    else
      mkm.helpers.flash('info', "File uploaded successfully, #{@filesWaiting.length} files left. Please wait... ")

  transferFile: (postData) ->
    $.ajax({
      type: "POST"
      url: "/articles/#{@model.id}/photos"
      data: postData
      success: =>

        @model.fetch({success: => @updateProgress()})
        unless @filesWaiting.length is 0
          setTimeout(@transferNextFile, 6000)
      error: (jqXhr, status, error) =>
        mkm.helpers.flash('error', "Error while uploading pictures #{status} - #{error}")
        @reset()
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
