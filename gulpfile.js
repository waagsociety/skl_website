var gulp = require('gulp'),
    sass = require('gulp-sass'),
    prefix = require('gulp-autoprefixer'),
    uglify = require('gulp-uglify'),
    concat = require('gulp-concat'),
    babel = require('gulp-babel');

gulp.task('styles', function() {
    gulp.src('src/styles/**/*.scss')
        .pipe(sass({outputStyle: 'compressed'}).on('error', sass.logError))
        .pipe(prefix({
    			browsers: ['last 2 versions'],
    			cascade: false
    		}))
        .pipe(gulp.dest('./assets/css'));
});

gulp.task('js', function() {
    gulp.src([
      'src/js/*.js',
			'src/js/vendors/promise-polyfill.js',
			'src/js/vendors/fetch.js'
    ])
    .pipe(babel({
        presets: ['es2015']
    }))
    // concat pulls all our files together before minifying them
    .pipe( concat('main.min.js') )
    // .pipe(uglify())
    .pipe(gulp.dest('./assets/js'))
});   

gulp.task('js2', function() {
    gulp.src([
      'src/js/vendors/dropzone.js',
			'src/js/vendors/html5-formdata-polyfill.js',
			'src/js/vendors/promise-polyfill.js',
			'src/js/vendors/fetch.js',
			'src/js/iframe/iframe.js'			
    ])
    .pipe(babel({
        presets: ['es2015']
    }))
    .pipe( concat('iframe.min.js') )
    .pipe(gulp.dest('./assets/js'))
});

gulp.task('watch', function () {
    gulp.watch('src/styles/**/*.scss',['styles']);
    gulp.watch('src/js/*.js',['js']);
});

gulp.task('default', ['styles', 'js', 'js2']);
gulp.task('start', ['watch']);
