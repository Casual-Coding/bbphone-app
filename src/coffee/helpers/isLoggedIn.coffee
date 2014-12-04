define (require) ->
  Handlebars = require("hbs/handlebars")
  Channel = require("channel")

  isLoggedIn = (options) ->
    console.log("isLoggedIn")
    if Channel.request("entity:user:current")
      return options.inverse(this)
    else
      return options.fn(this)

  Handlebars.registerHelper("isLoggedIn", isLoggedIn)