define (require) ->
  Handlebars = require("hbs/handlebars")
  Channel = require("channel")

  currentUser = ->
    Channel.request("entity:user:current")

  Handlebars.registerHelper("currentUser", currentUser)