define (require) ->
  Marionette = require("marionette")
  Template = require("hbs!components/threads/templates/item")

  class ThreadItemView extends Marionette.ItemView
    template: Template
    className: "post-list-item"

    onRender: ->
      if navigator.connection and navigator.connection.type isnt "wifi"
        @$el.find(".image.not-loaded").bind "click", (ev) =>
          @_loadImage(ev.currentTarget)
          ev.preventDefault()
          ev.stopPropagation()
      else
        @$el.find(".image.not-loaded").each (index, element) =>
          @_loadImage(element)

      @$el.find(".video.youtube").each (index, element) =>
        $element = $(element)
        id = $element.data("video")
          .match(/.*(?:youtu.be\/|v\/|u\/\w\/|embed\/|watch\?v=)([^#\&\?]*).*/)[1]

        $element.append("<iframe src=\"https://www.youtube.com/embed/#{id}\" frameborder=\"0\" allowfullscreen></iframe>")

      @$el.find(".trigger").bind "click", ->
        $(this).toggleClass("active")

    _loadImage: (element) ->
      image = new Image
      $this = $(element)

      image.onload = ->
        $image = $(this)
        $this
          .unbind("click")
          .removeClass("not-loaded is-loading")
          .addClass("loaded")
          .append($image)

      image.src = $this.data("image")
      $this.addClass("is-loading")
