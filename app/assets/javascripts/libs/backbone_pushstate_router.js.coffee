# Use absolute URLs  to navigate to anything not in your Router.
$(->
  # Use delegation to avoid initial DOM selection and allow all matching elements to bubble
  $('body').on("click", 'a', (evt) ->
    # Get the anchor href and protcol
    href = $(this).attr("href")
    protocol = this.protocol + "//"

    # Href is not necessarily present and we cannot know where to navigate the
    # user. In these cases, the <a> tag is certainly not a navigation link, but
    # instead a clickable element - perhaps with JavaScript event listeners
    # attached.
    return unless href

    # Only internal links are interesting
    if (href.match(/\//) or href.match(/\/\w+/)) and !href.match(/^http/) and !href.match(/^#$/)
      # Stop the event bubbling to ensure the link will not cause a page refresh.
      evt.preventDefault()
      mkm.routers.router.navigate(href, true)
  )
)
