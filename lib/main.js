require.config({
  baseUrl: "js",
  paths: {
    moment_de: "vendors/moment/locale/de",
    "hbs/handlebars": "vendors/require-handlebars-plugin/hbs/handlebars",
    "hbs/underscore": "vendors/require-handlebars-plugin/hbs/underscore",
    "hbs/i18nprecompile": "vendors/require-handlebars-plugin/hbs/i18nprecompile",
    "hbs/json2": "vendors/require-handlebars-plugin/hbs/json2",
    json: "vendors/requirejs-json/json",
    text: "vendors/requirejs-text/text",
    hbs: "vendors/require-handlebars-plugin/hbs"
  },
  locale: "de_DE",
  hbs: {
    helperDirectory: "helpers/"
  }
});

require(["app"],
  function(app) {
    app.start();
  }
);