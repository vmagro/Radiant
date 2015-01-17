module.exports = (grunt) ->
  grunt.initConfig
    pkg: grunt.file.readJSON("package.json")

    watch:
      coffee:
        files: ['lib/*.coffee', 'routes/*.coffee']
        tasks: ['coffee:build']

    coffee:
      build:
        options:
          bare: true
        files:
          'lib/light.js': ['lib/light.coffee']
          'lib/rgbtween.js': ['lib/rgbtween.coffee']
          'routes/lights.js': ['routes/lights.coffee']

  grunt.loadNpmTasks 'grunt-contrib-watch'
  grunt.loadNpmTasks 'grunt-contrib-coffee'

  grunt.registerTask 'default', ['build']
  grunt.registerTask 'build', ['coffee:build', 'watch']