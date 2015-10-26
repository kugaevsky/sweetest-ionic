gulp = require('gulp')
gutil = require('gulp-util')
bower = require('bower')
concat = require('gulp-concat')
sass = require('gulp-sass')
minifyCss = require('gulp-minify-css')
rename = require('gulp-rename')
sh = require('shelljs')
jade = require('gulp-jade')
coffee = require('gulp-coffee')
prefix = require('gulp-autoprefixer')
sequence = require('run-sequence');

# Paths to source
paths =
  jade: ['./src/jade/**/*.jade']
  sass: ['./src/sass/**/*.sass']
  coffee: ['./src/coffeescript/**/*.coffee']


# Gulp compilation tasks
gulp.task 'sass', (done) ->
  gulp.src(['./src/sass/application.sass'])
  .pipe sass()
  .on('error', sass.logError)
  .pipe prefix 'last 2 versions', 'ios_saf >= 7'
  .pipe minifyCss({ keepSpecialComments: 0 })
  .pipe rename({ extname: '.min.css' })
  .pipe gulp.dest('./www/css/')
  # .on('end', done)


gulp.task 'jade', (done) ->
  gulp.src(paths.jade)
  .pipe jade()
  .pipe gulp.dest('./www/')
  # .on('end', done)


gulp.task 'coffee', (done) ->
  gulp.src(paths.coffee)
  .pipe coffee()
  .pipe concat 'app.js'
  .pipe gulp.dest('./www/js')
  # .on('end', done)


# Gulp watch and default tasks
gulp.task 'default', ['compile', 'watch']
gulp.task 'compile', ['sass', 'jade', 'coffee']


gulp.task 'watch', () ->
  gulp.watch(paths.sass, ['sass'])
  gulp.watch(paths.jade, ['jade'])
  gulp.watch(paths.coffee, ['coffee'])


gulp.task 'install', ['git-check'], () ->
  bower.commands.install()
  .on 'log', (data) ->
    gutil.log 'bower', gutil.colors.cyan(data.id), data.message


gulp.task 'build', () ->
  sh.exec('ionic build ios')


gulp.task 'clean', () ->
  sh.exec('rm -r www plugins platforms node_modules hooks resources/ios')


gulp.task 'prepare', () ->
  sh.exec('npm run prepare')


gulp.task 'rebuild', () ->
  sequence 'clean', 'prepare', 'build'


gulp.task 'git-check', (done) ->
  if !sh.which('git')
    console.log(
      '  ' + gutil.colors.red('Git is not installed.'),
      '\n  Git, the version control system, is required to download Ionic.',
      '\n  Download git here:', gutil.colors.cyan('http://git-scm.com/downloads') + '.',
      '\n  Once git is installed, run \'' + gutil.colors.cyan('gulp install') + '\' again.'
    );
    process.exit(1)

  done()
