define (require) ->
  Marionette = require("marionette")
  Template = require("hbs!ui/range/templates/item")

  class UiRangeItemView extends Marionette.ItemView
    template: Template
    className: "range-wrapper"
    ui:
      range: ".range"
      track: ".range-track"
    active: no
    startValue: 0
    startPosition =
      x: 0
      y: 0

    events: (events = {}) ->
      events["touchstart.range @ui.range"] = "onStart"
      events

    initialize: ->
      @options.value = parseInt(@options.value, 10)
      @options.min = parseInt(@options.min, 10)
      @options.max = parseInt(@options.max, 10)

      @$body = $("body")
      @$body.on("touchend.range", @onEnd)
      @$body.on("touchmove.range", @onMove)

    onDestroy: ->
      @$body.off("touchend.range", @onEnd)
      @$body.off("touchmove.range", @onMove)

    onEnd: =>
      if @active
        @active = no
        @$body.removeClass("unselectable")
        @previousSpeed = 0

        if @startValue isnt @options.value and @options.channel
          @options.channel.trigger("range:change", @options.value)

    onStart: (ev) ->
      unless @active
        @active = yes
        @startValue = @options.value
        @startPosition =
          x: ev.originalEvent.touches[0].clientX
          y: ev.originalEvent.touches[0].clientY

        @previousSpeed = 0

    onMove: (ev) =>
      if @active
        activeTouch = ev.originalEvent.changedTouches[0]
        @$body.addClass("unselectable")

        speedOffset = Math.abs(
          activeTouch.clientY - @startPosition.y
        )

        if speedOffset > 200
          speed = 0.025
        else if speedOffset > 150
          speed = 0.1
        else if speedOffset > 100
          speed = 0.25
        else if speedOffset > 50
          speed = 0.5
        else
          speed = 1

        if @previousSpeed isnt speed
          @startValue = @options.value
          @previousSpeed = speed
          @startPosition.x = activeTouch.clientX

        trackingOffset = activeTouch.clientX - @startPosition.x
        realValue = Math.floor(
          (@options.max - @options.min) * (trackingOffset / @ui.track.width())
        )

        calculatedValue = @startValue + Math.floor(realValue * speed)
        calculatedValue = Math.max(
          @options.min, Math.min(
            calculatedValue, @options.max
          )
        )

        @options.value = calculatedValue
        @ui.track.attr("data-value", "#{@options.value}/#{@options.max}")

        calculatedPosition = calculatedValue * @ui.track.width() /
          (@options.max - @options.min)

        @ui.range.css("left", parseInt(calculatedPosition - @ui.range.width() / 2, 10))

        ev.preventDefault()
        ev.stopPropagation()

    onRender: ->
      setTimeout =>
        calculatedPosition = @options.value * @ui.track.width() /
          (@options.max - @options.min)
        @ui.range.css "left",
          parseInt(calculatedPosition - @ui.range.width() / 2, 10)
      , 100

    serializeData: ->
      data = {}
      data.min = @options.min
      data.max = @options.max
      data.value = @options.value
      data
