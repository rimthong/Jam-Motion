module.exports = (grunt) ->
  grunt.initConfig
    pkg: grunt.file.readJSON 'package.json'

    clean: ['bower_components', 'vendor', 'server']

    bower:
      install:
        options:
          targetDir: 'vendor'
          install: true

    coffee:
      compile:
        files:
          'server/app.js': 'src/server/app.coffee'
          'server/routes/index.js' : 'src/server/routes/index.coffee'
          'server/routes/test.js' : 'src/server/routes/test.coffee'
          'server/public/javascripts/jam.js': [
            'src/front/js/jam.coffee'
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
      js:
        src: ['vendor/jquery/jquery.min.js',
              'vendor/bootstrap/bootstrap.min.js',
              'vendor/underscore/underscore.min.js'
            ]
        dest: 'server/public/javascripts/vendor.js'
      css:
        src: ['vendor/bootstrap/bootstrap.css',
              'vendor/font-awesome/css/font-awesome.css']
        dest: 'server/public/stylesheets/vendor.css'

    stylus:
      compile:
        files:
          'server/public/stylesheets/jamation.css': ['src/front/css/jamation.styl']

    copy:
      font:
        files: [expand: true, flatten: true, src: ['vendor/font-awesome/fonts/*', 'bower_components/bootstrap/dist/fonts/*'], dest: 'server/public/fonts']
      img:
        files: [expand: true, flatten: true, src: ['components/bootstrap/img/*.png', 'images/*.png'], dest: 'server/public/img']
      views:
        files: [ expand:true, flatten: true, filter:'isFile', src: ['src/front/views/**'], dest: 'server/views/']

    watch:
      coffee:
        files: 'src/**/*.coffee'
        tasks: ['coffeelint', 'build']
      stylus:
        files: 'src/**/*.styl'
        tasks: ['build']

  grunt.loadNpmTasks 'grunt-bower-task'
  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-contrib-stylus'
  grunt.loadNpmTasks 'grunt-contrib-concat'
  grunt.loadNpmTasks 'grunt-contrib-copy'
  grunt.loadNpmTasks 'grunt-contrib-watch'
  grunt.loadNpmTasks 'grunt-contrib-clean'
  grunt.loadNpmTasks 'grunt-coffeelint'

  grunt.registerTask 'build', ['coffee', 'stylus', 'concat', 'copy']
  grunt.registerTask 'lint', ['coffeelint']

  grunt.registerTask 'default', ['clean', 'bower', 'build']

