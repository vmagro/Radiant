module.exports = (grunt) ->
  grunt.initConfig
    pkg: grunt.file.readJSON("package.json")

    watch:
      coffee:
        files: ['app.coffee', 'lib/*.coffee', 'routes/*.coffee', 'coffee/*.coffee']
        tasks: ['coffee:build', 'express:dev']
        options:
          spawn: false

    coffee:
      build:
        options:
          bare: true
        files:
          'lib/light.js': ['lib/light.coffee']
          'lib/rgbtween.js': ['lib/rgbtween.coffee']
          'lib/waiting-animation.js': ['lib/waiting-animation.coffee']
          'lib/cycle-animation.js': ['lib/cycle-animation.coffee']
          'lib/cal-animation.js': ['lib/cal-animation.coffee']
          'routes/lights.js': ['routes/lights.coffee']
          'public/js/app-all.js': ['coffee/app.coffee']
          'public/js/light-controls.js': ['coffee/light-controls.coffee']
          'public/js/index.js': ['coffee/index.coffee']
          'app.js': ['app.coffee']

    express:
      dev:
        options:
          script: 'app.js'

  grunt.loadNpmTasks 'grunt-contrib-watch'
  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-express-server'

  grunt.registerTask 'default', ['build']
  grunt.registerTask 'build', ['coffee:build', 'express:dev', 'watch']
