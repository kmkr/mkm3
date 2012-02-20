class mkm.views.photos.ThumbnailMatrixView extends Backbone.View
  template: JST['photos/thumbnailmatrix']
  className: 'thumbnailMatrixView'
  currentPage: 1
  pages: 0
  views: []
  columns: 3
  rows: 2

  events:
    "click .next"   : "paginateNext"
    "click .prev"   : "paginatePrev"
    "click [data-page]"   : "paginateByNum"

  paginateNext: (e) =>
    e.preventDefault()
    if @currentPage < @pages
      @paginate(++@currentPage)

  paginatePrev: (e) =>
    e.preventDefault()
    if @currentPage > 1
      @paginate(--@currentPage)

  paginateByNum: (e) =>
    e.preventDefault()
    index = Number($(e.currentTarget).attr('data-page'))
    @paginate(index)

  paginate: (index) ->
    @currentPage = index
    console.log("current page er %s", index)
    @$('.page').hide()
    @$('.page').eq(index - 1).show()
    @$('.pagination li').removeClass('active')
    @$('.pagination li').eq(index).addClass('active')

  createRow: (photos) ->
    $('<div>').addClass('imgrow')

  createPage: (index) ->
    p = $('<div>').addClass('page').attr('data-index', index)
    p

  addPageToPagination: (num) ->
    a = $('<a>').attr('href', '#').attr('data-page', num).text(num)
    li = $('<li>')
    li.append(a)
    @$('.pagination li a.next').parent().before(li)


  render: ->
    $(@el).html(@template)

    colNum = 0
    rowNum = 0
    pageNum = 1
    page = @createPage(pageNum)
    row = @createRow()
    @collection.forEach((photo, index) =>
      colNum++
      t = new mkm.views.photos.ThumbnailPhotoView({model: photo})
      row.append($(t.render().el))
      @views.push(t)

      if colNum is @columns or index + 1 is @collection.length
        colNum = 0
        page.append(row)
        row = @createRow()
        rowNum++

        if rowNum is @rows or index + 1 is @collection.length
          @$('.thumbnails').append(page)
          @addPageToPagination(pageNum)
          page = @createPage(++pageNum)
          @pages++
          rowNum = 0
    )
    @paginate(1)

    @
