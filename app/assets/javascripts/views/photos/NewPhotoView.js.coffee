class mkm.views.photos.NewPhotoView extends Backbone.View
  template: JST['photos/new']

  className: 'newPhotoView'
  filesWaiting: []
  filesComplete: 0
  ongoingTransfer: false
  numErrors: 0

  events:
    "drop .dropArea"        : "fileDropped"
    "dragleave .dropArea"   : "dragLeave"
    "dragenter .dropArea"   : "dragEnter"
    "dragover .dropArea"    : "dragOver"

  fileDropped: (evt) =>
    evt.preventDefault()
    evt.stopPropagation()
    $(evt.target).removeClass('over')

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
          postData =
            binary: image
            fileName: fileName

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
    @numErrors = 0
    @$('.progress').removeClass('active')
    @$('.progress .bar').width('0')
    @$('.loader').hide()

  transferNextFile: =>
    @transferFile(@filesWaiting.shift())

  updateProgress: ->
    @filesComplete++
    @$('.progress .bar').width("#{(@filesComplete / @totalFiles) * 100}%")

    if @filesWaiting.length is 0
      if @numErrors is 0
        mkm.helpers.flash('info', "All files uploaded successfully")
      else
        mkm.helpers.flash('error', "Upload finished but #{@numErrors} of #{@totalFiles} failed, see log below for details.")

      @reset()
    else
      mkm.helpers.flash('info', "File uploaded successfully, #{@filesWaiting.length} files left. Please wait... ")

  _writeToResults: (msg, status = 'success') ->
    label = $('<span>').addClass("label label-#{status}").text(status)
    p = $('<p>').html(msg)
    p.prepend(label)
    @$('.results').append(p)

  transferFile: (postData) ->
    $.ajax({
      type: "POST"
      url: "/articles/#{@model.id}/photos"
      data: "binary_data=#{postData.binary}&file_name=#{postData.fileName}"
      success: =>
        @model.fetch({
          success: =>
            @updateProgress()
            @_writeToResults("Uploaded: #{postData.fileName}")
          error: (jqXhr, status, error) =>
            @updateProgress()
            @_writeToResults("Uploaded: #{postData.fileName} but was unable to read back the new photo. After the uploads are finished, you need to refresh the site to see this photo. Error message: '#{status}'")
            console.log("Error re-fetching #{postData.fileName}. Status: #{status}, Error: #{error}")
        })
        unless @filesWaiting.length is 0
          setTimeout(@transferNextFile, 6000)
      error: (jqXhr, status, error) =>
        mkm.helpers.flash('error', "Error uploading picture #{postData.fileName} (#{error})")
        @updateProgress()
        @numErrors++
        @_writeToResults("ERROR: #{postData.fileName}", 'warning')
        unless @filesWaiting.length is 0
          setTimeout(@transferNextFile, 6000)
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
