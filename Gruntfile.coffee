module.exports = (grunt) ->
  grunt.initConfig
    pkg: grunt.file.readJSON 'package.json'

    clean: ['server']

    coffee:
      compile:
        files:
          'server/app.js': 'src/server/app.coffee'
          'server/routes/index.js' : 'src/server/routes/index.coffee'
          'server/routes/test.js' : 'src/server/routes/test.coffee'
          'server/public/javascripts/socket.js': [
            'src/front/js/socket.coffee'
          ]
        options:
          bare: true
          join: true
          sourceMap: true

    coffeelint:
      app: ['src/**/*.coffee', 'test/**/*.coffee']
      options:
        arrow_spacing:
          level: 'warn'
        colon_assignment_spacing:
          spacing:
            left: 0
            right: 1
          level: 'warn'
        max_line_length:
          value: 120
          level: 'warn'
        no_implicit_braces:
          level: 'ignore'
        no_trailing_semicolons:
          level: 'error'
        missing_fat_arrows:
          level: 'warn'
        no_empty_param_list:
          level: 'warn'
        cyclomatic_complexity:
          value: 5
          level: 'warn'
        no_implicit_parens:
          level: 'ignore'
        space_operators:
          level: 'warn'

    concat:
      temp: #XXX Temporary, until we coffescript jam.js
        src: ['public/javascripts/jam.js']
        dest: 'server/public/javascripts/jam.js'
      js:
        src: ['vendor/jquery.js',
              'vendor/bootstrap.min.js',
              'vendor/owl.carousel.min.js',
              'vendor/underscore-min.js']
        dest: 'server/public/javascripts/vendor.js'
      css:
        src: ['vendor/bootstrap.min.css'
              'vendor/owl.carousel.css',
              'vendor/owl.theme.css.css']
        dest: 'server/public/stylesheets/vendor.css'

    stylus:
      compile:
        files:
          'server/public/stylesheets/jamation.css': ['src/front/css/jamation.styl']

    copy:
      views:
        files: [ expand:true, flatten: true, filter:'isFile', src: ['views/**'], dest: 'server/views/']
      images:
        files: [ expand:true, flatten: true, filter:'isFile', src: ['public/images/**'], dest: 'server/public/images']
      instruments:
        files: [ expand:true, flatten: false, filter:'isFile', src: ['instruments/**'], dest: 'server']
      owlimages:
        files: [ expand:true, flatten: true, filter:'isFile', src: ['public/stylesheets/owl-carousel/*.png'], dest: 'server/public/stylesheets/']

    watch:
      coffee:
        files: 'src/**/*.coffee'
        tasks: ['coffeelint', 'build']
      stylus:
        files: 'src/**/*.styl'
        tasks: ['build']

  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-contrib-stylus'
  grunt.loadNpmTasks 'grunt-contrib-concat'
  grunt.loadNpmTasks 'grunt-contrib-copy'
  grunt.loadNpmTasks 'grunt-contrib-watch'
  grunt.loadNpmTasks 'grunt-contrib-clean'
  grunt.loadNpmTasks 'grunt-coffeelint'

  grunt.registerTask 'build', ['coffee', 'stylus', 'concat', 'copy']
  grunt.registerTask 'lint', ['coffeelint']

  grunt.registerTask 'default', ['clean', 'build']

