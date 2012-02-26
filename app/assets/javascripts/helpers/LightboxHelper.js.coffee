mkm.helpers.lightboxHelper = {

  init: (selector, callbacks = {}) ->
    opts =
      prevEffect    : "fade"
      nextEffect    : "fade"
      openSpeed     : "fast"
      closeSpeed     : "fast"
      helpers:
        title:
          type: "outside"
        overlay:
          opacity: 0.8
          css: 'background-color': "#000"
    $(selector).fancybox(_.extend(opts, callbacks))

  open: (url) ->
    $.fancybox.open(url)
}
