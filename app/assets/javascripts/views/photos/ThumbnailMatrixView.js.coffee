class mkm.views.photos.ThumbnailMatrixView extends Backbone.View
  template: JST['photos/thumbnailmatrix']
  className: 'thumbnailMatrixView'
  currentPage: 0
  pages: 0
  views: []
  columns: 4
  rows: 4

  initialize: (opts = {}) ->
    @collection.bind('remove', @render)
    @displayPhoto = opts.displayPhoto

  events:
    "click .next"   : "paginateNext"
    "click .prev"   : "paginatePrev"
    "click [data-page]"   : "paginateByNum"

  paginateNext: (e) =>
    e.preventDefault()
    if @currentPage < @pages
      @paginate(@currentPage + 1)

  paginatePrev: (e) =>
    e.preventDefault()
    if @currentPage > 1
      @paginate(@currentPage - 1)

  paginateByNum: (e) =>
    e.preventDefault()
    index = Number($(e.currentTarget).attr('data-page'))
    @paginate(index)

  paginate: (index) ->
    index = 1 if index is 0
    return if @currentPage is index

    @currentPage = index
    @$('.page').animate({opacity: 0}, 100, 'swing', =>
        @$('.page').hide()
        @$('.page').eq(index - 1).show().css('opacity', 0).animate({opacity: 1}, 100, 'swing')
    )
    @$('.pagination li').removeClass('active')
    @$('.pagination li').eq(index).addClass('active')

  createPage: (index) ->
    p = $('<div>').addClass('page').attr('data-index', index)
    ul = $('<ul>').addClass('thumbnails')
    p.append(ul)
    p

  addPageToPagination: (num) ->
    a = $('<a>').attr('href', '#').attr('data-page', num).text(num)
    li = $('<li>')
    li.append(a)
    @$('.pagination li a.next').parent().before(li)

  leave: ->
    @collection.unbind('remove', @render)


  render: =>
    $(@el).html(@template)

    colNum = 0
    pageNum = 1
    page = @createPage(pageNum)
    thumbCollectionId = "thumbs_#{new Date().getTime()}"
    @collection.forEach((photo, index) =>
      colNum++
      t = new mkm.views.photos.ThumbnailPhotoView({model: photo, thumbCollectionId: thumbCollectionId, size: 'small'})
      page.find('ul').append($(t.render().el).addClass('span3'))
      @views.push(t)

      if colNum is @columns * @rows or index + 1 is @collection.length
        colNum = 0
        @$('.gallery').append(page)
        @addPageToPagination(pageNum)
        page = @createPage(++pageNum)
        @pages++
    )
    @paginate(@currentPage)

    mkm.helpers.lightboxHelper.init(@$('.thumb-wrapper > a'), {
      afterShow: (lightbox) =>
        @paginate(Math.ceil((lightbox.index + 1) / (@columns*@rows)))
      beforeShow: (lightbox) =>
        id = $(lightbox.element).attr('data-id')
        p = @collection.get(id)
        mkm.routers.router.navigate("articles/#{p.get('article').id}/photos/#{p.id}")
      beforeClose: (lightbox) =>
        id = $(lightbox.element).attr('data-id')
        p = @collection.get(id)
        mkm.routers.router.navigate("articles/#{p.get('article').id}")
    })

    if @displayPhoto
      mkm.helpers.lightboxHelper.open(@displayPhoto.get('photo').large.url)

    @
