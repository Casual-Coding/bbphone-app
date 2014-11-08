define (require) ->
  Handlebars = require("hbs/handlebars")
  moment = require("moment")
  require("moment_de")
  _ = require("underscore")

  moment.locale("de")

  date = (format, date) ->
    if format is "fromNow"
      return moment(date).fromNow()

    if date and not _.isEmpty(date)
      moment(date).format(format)
    else
      "Keine Angabe"

  Handlebars.registerHelper("date", date)