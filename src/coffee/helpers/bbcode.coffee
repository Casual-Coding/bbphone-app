define (require) ->
  Handlebars = require("hbs/handlebars")
  BBCodeParser = require("bbcode")

  bbcode = (text) ->
    parser = new BBCodeParser()
    new Handlebars.SafeString(parser.parse(text).replace(/\n/g, "<br>"))

  Handlebars.registerHelper("bbcode", bbcode)