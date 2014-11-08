define (require) ->
  Wreqr = require("backbone.wreqr")

  channel = new Wreqr.Channel("global")
  wrapChannelFunctions = (channel) ->
    reqres: channel.reqres
    vent: channel.vent
    commands: channel.commands
    connectEvents: -> channel.connectEvents.apply(channel, arguments)
    connectCommands: -> channel.connectCommands.apply(channel, arguments)
    connectRequests: -> channel.connectRequests.apply(channel, arguments)
    trigger: -> channel.vent.trigger.apply(channel.vent, arguments)
    execute: -> channel.commands.execute.apply(channel.commands, arguments)
    request: -> channel.reqres.request.apply(channel.reqres, arguments)
    reset: -> channel.reset.apply(channel)

  channel.connectRequests
    "channel": (name) ->
      _channel = new Wreqr.Channel(name)
      wrapChannelFunctions(_channel)

  wrapChannelFunctions(channel)