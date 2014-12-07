define (require) ->
  Handlebars = require("hbs/handlebars")
  BBCodeParser = require("bbcodeparser")
  require("xregexp")

  bbcode = (text) ->
    new Handlebars.SafeString(BBCodeParser.parse(text))

  Handlebars.registerHelper("bbcode", bbcode)