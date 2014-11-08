# bbPhone

> An iOS client for the mods.de boards

## Introduction

bbPhone is an iOS client for the mods.de boards, written in [CoffeeScript](http://coffeescript.org/) and depends on the [Marionette.js](https://github.com/marionettejs/backbone.marionette) library.

## Building bbPhone

The bbphone source files are originally written in the [CoffeeScript](http://coffeescript.org/) meta-language. However, the bbPhone library file is a compiled JavaScript file.

Our build script compiles the CoffeeScripts. To run the script, follow these steps:

1. Download and install [Ruby](https://www.ruby-lang.org).
2. Download and install [Node.js](http://nodejs.org/).
3. Open a shell and type in the commands in the following steps.
4. Install the Ruby gem for handling ruby dependencies.

   ```sh
   sudo gem install bundler
   ```

5. Change into the bbPhone root directory.
6. Install Ruby gem dependencies with bundler.

   ```sh
   bundler install
   ```

7. Start the build (will install dependencies and build).

   ```sh
   npm install
   ```

8. Start the iOS Simulator

   ```sh
   npm run build:ios
   ```

This creates a ready to run application in `phonegap/platforms` dir

## Developing bbPhone

How to start the development environment:

1. Follow the steps for [building bbPhone](#building-bbphone) (skip step 8).
2. Start the watcher

   ```sh
   npm run watch
   ```

3. Start the server

   ```sh
   npm run server
   ```

4. Open http://localhost:7000 in your favorite browser.

If you want to access bbPhone with the [PhoneGap Developer App](http://app.phonegap.com/) just run `npm run serve` and you should be good to go.