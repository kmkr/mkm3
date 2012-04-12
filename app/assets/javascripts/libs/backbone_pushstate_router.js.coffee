# Use absolute URLs  to navigate to anything not in your Router.
$(->
  # Use delegation to avoid initial DOM selection and allow all matching elements to bubble
  $('body').on("click", 'a', (evt) ->
    # Get the anchor href and protcol
    href = $(this).attr("href")
    protocol = this.protocol + "//"

    # Href is not necessarily present
    return unless href

    # Only internal links are interesting
    if (href.match(/\//) or href.match(/\/\w+/)) and !href.match(/^http/) and !href.match(/^#$/)
      # Stop the event bubbling to ensure the link will not cause a page refresh.
      evt.preventDefault()
      mkm.routers.router.navigate(href, true)
  )
)
