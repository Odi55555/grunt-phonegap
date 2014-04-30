xmldom = require 'xmldom'
path = require 'path'

module.exports = screenOrientation = (grunt) ->
  helpers = require('../../../../helpers')(grunt)

  set: (fn) ->
    dom = xmldom.DOMParser
    
    screenOrientation = helpers.config 'screenOrientation'
    if screenOrientation
      phonegapPath = helpers.config 'path'
      manifestPath = path.join phonegapPath, 'platforms', 'android', 'AndroidManifest.xml'
      manifest = grunt.file.read manifestPath
      grunt.log.writeln "Setting screenOrientation to #{screenOrientation} in #{manifestPath}"

      doc = new dom().parseFromString manifest, 'text/xml'
      activity = doc.getElementsByTagName('activity')[0];
      activity.setAttribute 'android:screenOrientation', screenOrientation

      grunt.file.write manifestPath, doc

    if fn then fn()
