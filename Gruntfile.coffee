module.exports = (grunt) ->

  coffeeFiles = [
    "routes/*.coffee"
    "src/coffee/*.coffee"
    "test/*.coffee"
    "app.coffee"
  ]

  grunt.initConfig
    bowerful:
      src:
        packages:
          "jquery": ""
          "handlebars": ""
        store: "lib"
      test:
        packages:
          "sinonjs": ""
        store: "test/lib"

    express:
      dev:
        options:
          cmd: "coffee"
          script: "app.coffee"

    coffeelint:
      files: coffeeFiles
      gruntfile: ["Gruntfile.coffee"]

    watch:
      coffee:
        options:
          livereload: true
          nospawn: true
        files: coffeeFiles
        tasks: [
          "express:dev"
          "coffeelint:files"
          "test"
        ]

    clean:
      files: [
        "tmp"
      ]

    coffee:
      src:
        options:
          sourceMap: true
        expand: true,
        flatten: true,
        cwd: "src/coffee"
        src: ["**/*.coffee"]
        dest: "public/javascripts"
        ext: ".js"
      test:
        options:
          sourceMap: true
        expand: true,
        flatten: true,
        cwd: "test/coffee"
        src: ["**/*.coffee"]
        dest: "tmp/test/js"
        ext: ".js"

    jasmine:
      test:
        src: coffeeFiles
        options:
          specs: "tmp/test/js/*Spec.js"
          helpers: [

          ]
          vendor: [

          ]
          keepRunner: true
      coverage:
        src: coffeeFiles
        options:
          specs: "tmp/test/js/*Spec.js"
          helpers: [

          ]
          vendor: [

          ]
          template: require("grunt-template-jasmine-istanbul")
          templateOptions:
            coverage: "tmp/coverage/coverage.json"
            report: [
              { type: "lcov", options: { dir: "tmp/coverage" } }
              { type: "text", options: {} }
            ]
#            thresholds:
#              lines: 80
#              statements: 80
#              branches: 80
#              functions: 80

  require("matchdep").filterDev("grunt-!(template)*").forEach grunt.loadNpmTasks

  grunt.registerTask "server", "Start a web server to host the app.",
    ["express:dev", "watch"]

  grunt.registerTask "test-no-coverage", "Run Jasmine tests without coverage",
    ["coffee", "jasmine:test"]

  grunt.registerTask "test", "Run Jasmine tests",
    ["coffee", "jasmine:coverage"]

  grunt.registerTask "default", "Run for first time setup.",
    ["clean", "bowerful", "coffeelint", "test"]