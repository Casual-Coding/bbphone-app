define (require) ->
  Marionette = require("marionette")
  Template = require("hbs!components/threads/templates/item")

  class ThreadItemView extends Marionette.ItemView
    template: Template
    className: "post-list-item"

    onRender: ->
      @$el.find(".image.not-loaded").bind "click", (ev) ->
        image = new Image
        $this = $("[data-image=\"#{$(this).data("image")}\"]")

        image.onload = ->
          $image = $(this)
          $this
            .unbind("click")
            .removeClass("not-loaded is-loading")
            .addClass("loaded")
            .append($image)

        image.src = $this.data("image")
        $this.addClass("is-loading")

        ev.preventDefault()
        ev.stopPropagation()
