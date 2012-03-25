// Use absolute URLs  to navigate to anything not in your Router.
$(function() {
  // Only need this for pushState enabled browsers
  if (Backbone.history && Backbone.history._hasPushState) {

    // Use delegation to avoid initial DOM selection and allow all matching elements to bubble
    $(document).delegate("a", "click", function(evt) {
      // Get the anchor href and protcol
      var href = $(this).attr("href");
      var protocol = this.protocol + "//";

      // Only internal links are interesting
      if (!href.match(/^http/)) {

        // Stop the event bubbling to ensure the link will not cause a page refresh.
        evt.preventDefault();
        mkm.routers.router.navigate(href, true);
      }
    });

  }
});
