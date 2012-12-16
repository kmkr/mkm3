mkm.helpers.lightboxHelper = {

  init: (selector, callbacks = {}) ->
    opts =
      prevEffect    : "fade"
      nextEffect    : "fade"
      openSpeed     : "fast"
      closeSpeed    : "fast"
      type          : 'image'
      helpers:
        title:
          type: "inside"
        overlay:
          opacity: 0.8
    $(selector).fancybox(_.extend(opts, callbacks))

}
