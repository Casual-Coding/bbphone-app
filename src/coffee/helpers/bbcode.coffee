define (require) ->
  Handlebars = require("hbs/handlebars")
  BBCodeParser = require("bbcode2")

  bbcode = (text) ->
    new Handlebars.SafeString(BBCodeParser.parse(text))

  Handlebars.registerHelper("bbcode", bbcode)