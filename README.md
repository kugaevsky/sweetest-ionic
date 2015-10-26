# Ionic skeleton

The most sweetest syntax for [Ionic](http://ionicframework.com/).

* [jade](http://jade-lang.com/) for HTML
* [Sass](http://sass-lang.com/) for CSS
* [Coffeescript](http://coffeescript.org/) for JavaScript
* [Gulp](http://gulpjs.com/) for building automation

CSS vendor prefixes handled by [autoprefixer](https://github.com/postcss/autoprefixer).

## Source

All source files stored in `src` directory.
Source compiled to `www` directory.

## Build

Install all node and bower dependencies

    $ npm install
    $ npm run prepare

### Plain HTML5 files

* `gulp` to compile and watch HTML5 files

### Xcode project

* `gulp build` to build an Xcode project
* `gulp rebuild` to clean up **all dependencies** and rebuild project from scratch

### iOS ipa archive

* work in progress

## Development

* `ionic serve` to compile application for browser and start dev server
* `ionic emulate` to compile application for emulator and start it
