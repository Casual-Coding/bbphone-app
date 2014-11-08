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
    hbs: "vendors/require-handlebars-plugin/hbs",
    bbcode: "vendors/bbcode",
    regexp: "vendors/regexp"
  },
  shim: {
    bbcode: {
      exports: "BbCodeParser",
      deps: [ "regexp" ]
    },
    regexp: {
      exports: "XRegExp"
    }
  },
  locale: "de_DE",
  hbs: {
    helperDirectory: "helpers/"
  }
});

require(["cordova.js", "app"], function(_trash, app) {
  var startup = function() {
    app.start({ isCordova: true });
  };

  // Poll for Phonegap (Cordova) to avoid race conditions
  // with the deviceready event. For local development,
  // startup may need to be called directly.
  (function checkCordova() {
    // Check if Cordova exists
    if (window.cordova) {
      // Listen for the deviceready event
      document.addEventListener('deviceready', startup, false);
    } else {
      // If Cordova does not exist, check again in 1/60th second
      setTimeout(checkCordova, 16);
    }
  }());
}, function(err) {
  require(["app"], function(app) {
    app.start({ isCordova: false });
  });
});