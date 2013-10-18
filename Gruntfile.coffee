module.exports = (grunt) ->

  coffeeFiles = [
    "routes/*.coffee"
    "src/coffee/*.coffee"
    "app.coffee"
  ]
  clientVendorFiles = [
    "lib/jquery/jquery.js"
    "lib/handlebars/handlebars.js"
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
        files: [coffeeFiles, ["test/coffee/**/*.coffee"]]
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
      clientTest:
        src: "public/javascripts/*.js"
        options:
          specs: "tmp/test/js/*Spec.js"
          helpers: [

          ]
          vendor: clientVendorFiles
          keepRunner: true
      clientCoverage:
        src: "public/javascripts/*.js"
        options:
          specs: "tmp/test/js/*Spec.js"
          helpers: [

          ]
          vendor: clientVendorFiles
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

    bump:
      options:
        pushTo: 'all --all'

  require("matchdep").filterDev("grunt-!(template)*").forEach grunt.loadNpmTasks

  grunt.registerTask "server", "Start a web server to host the app.",
    ["express:dev", "watch"]

  grunt.registerTask "test-no-coverage", "Run Jasmine tests without coverage",
    ["coffee", "jasmine:clientTest"]

  grunt.registerTask "test", "Run Jasmine tests",
    ["coffee", "jasmine:clientCoverage"]

  grunt.registerTask "default", "Run for first time setup.",
    ["clean", "bowerful", "coffeelint", "test"]