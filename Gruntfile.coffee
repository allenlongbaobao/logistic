fs = require 'fs'
module.exports = (grunt)-> 
  process.env.DEBUG = 'dust'
  grunt.initConfig
    clean: ['src-temp', 'bin', 'test-bin']
    copy: 
      main:
        files: [expand: true, cwd: 'resource/', src: ['src'], dest: 'bin/']
      test:
        files: [expand: true, cwd: 'test', src: ['fixtures/**', 'helper.ls'], dest: 'test-temp/']
    concat:
      src:
        options:
          banner: "debug = require('debug')('logistic-follower')\n"
        files: [
          expand: true
          cwd: 'src'
          src: ['**/*.ls']
          dest: 'src-temp/'
          ext: '.ls'
        ]
      test:
        options: 
          banner: fs.readFileSync('test/header.ls', 'utf-8')
        files: [
          expand: true
          cwd: 'test'
          src: ['**/test-*.ls']
          dest: 'test-temp/'
          ext: '.ls'
        ]
    livescript:
      src:
        files: [
          expand: true
          flatten: false
          cwd: 'src-temp/'
          src: ['**/*.ls']
          dest: 'bin/'
          ext: '.js'
        ]
      test:
        files: [
          expand: true
          flatten: false
          cwd: 'test-temp/'
          src: ['**/*.ls']
          dest: 'test-bin'
          ext: '.js'
        ]
    watch:
      auto:
        files: ['src/**/*.ls', 'test/**/*.ls']
        tasks: ['concat', 'livescript']
        options:
          spawn: true
    simplemocha:
      all: 
        src: ['test-bin/**/test-*.js']
        options:
          timeout: 3000
          reporter: 'spec'
    nodemon:
      all:
        options:
          file: 'bin/app.js'
          watchedFolders: ['bin']
    concurrent:
      target:
        tasks:
          ['nodemon', 'watch:auto']
        options:
          logConcurrentOutput: true
  grunt.loadNpmTasks "grunt-livescript"
  grunt.loadNpmTasks "grunt-simple-mocha"
  grunt.loadNpmTasks "grunt-nodemon"
  grunt.loadNpmTasks "grunt-env"
  grunt.loadNpmTasks "grunt-contrib-concat"
  grunt.loadNpmTasks "grunt-contrib-jshint"
  grunt.loadNpmTasks "grunt-contrib-watch"
  grunt.loadNpmTasks "grunt-contrib-clean"
  grunt.loadNpmTasks "grunt-concurrent"
  grunt.loadNpmTasks "grunt-contrib-copy"

  grunt.registerTask "default", ["clean", "copy", "concat:src", "livescript",  'concurrent']
  grunt.registerTask "test", ["copy", "concat:test", "livescript:test",  'simplemocha']

  grunt.event.on 'watch', (action, filepath)->
    console.log 'filepath: ', filepath
    grunt.config ['livescript', 'src'], filepath
