autoprefixer    = require 'autoprefixer'
cssnano         = require 'cssnano'
del         	= require 'del'
gulp            = require 'gulp'
imagemin        = require 'gulp-imagemin'
newer           = require 'gulp-newer'
plumber         = require 'gulp-plumber'
postcss         = require 'gulp-postcss'
rename          = require 'gulp-rename'
sass            = require 'gulp-sass'
uglify          = require 'gulp-uglify'
coffee			= require 'gulp-coffee'
pug				= require 'gulp-pug'
notify			= require 'gulp-notify'
sass.compiler	= require 'node-sass'
babel			= require 'gulp-babel'

cleanTask = ->
	del [
		'build/*'
		'!build'
		'!build/assets/images/*'
		'!build/assets/static/*'
	]

coffeeTask = ->
	return gulp
		.src ['./source/**/[!_]*.coffee']
		.pipe plumber()
		.pipe coffee bare: true
		# .pipe babel presets: ['@babel/env']
		.pipe gulp.dest './build'
		# .pipe notify 'coffee Task done!'

pugTask = ->
	return gulp
		.src ['./source/**/[!_]*.pug']
		.pipe plumber()
		.pipe pug()
		.pipe gulp.dest './build'
		# .pipe notify 'pug task done!'

sassTask = ->
	return gulp
		.src ['./source/**/[!_]*.scss', './source/**/[!_]*.sass']
		.pipe plumber()
		.pipe sass outputStyle: 'expanded'
		.pipe postcss [autoprefixer(), cssnano()]
		.pipe gulp.dest './build'
		# .pipe notify 'sass task done!'

imageminTask = ->
	return gulp
		.src ['./source/images/**/*']
		.pipe newer './build/images/'
		.pipe imagemin 
				progressive: true
				svgoPlugins: [{removeViewBox: false}]
		.pipe gulp.dest './build/images'		
		# .pipe notify 'image opimize done!'

copyTask = ->
	return gulp
		.src ['./source/assets/static/**/*']
		.pipe newer './build/assets/static/'
		.pipe gulp.dest './build/assets/static'
		


watchTask = ->
	gulp.watch './source/**/*.coffee', coffeeTask
	gulp.watch './source/**/*.pug', pugTask
	gulp.watch ['./source/**/*.scss', './source/**/*.sass'], sassTask
	gulp.watch './source/assets/images/**/*', imageminTask
	gulp.watch './source/assets/static/**/*', copyTask
	return

gulp.task 'default', gulp.series cleanTask, gulp.parallel(coffeeTask, pugTask, sassTask, imageminTask, copyTask), watchTask
