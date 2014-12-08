define (require) ->
  Channel = require("channel")
  View = require("ui/range/views/itemView")

  Channel.connectRequests
    "ui:range": (options) ->
      view = new View(options)
