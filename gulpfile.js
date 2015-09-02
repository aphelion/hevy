var gulp = require('gulp'),
    webserver = require('gulp-webserver'),
    del = require('del'),
    sass = require('gulp-sass'),
    sourcemaps = require('gulp-sourcemaps'),
    browserify = require('browserify'),
    source = require('vinyl-source-stream'),
    buffer = require('vinyl-buffer'),
    uglify = require('gulp-uglify'),
    gutil = require('gulp-util');

var CacheBuster = require('gulp-cachebust');
var cachebust = new CacheBuster();

gulp.task('clean', function () {
    return del(['dist']);
});

gulp.task('build-js', ['clean'], function () {
    return browserify({entries: './app/js/app.js', debug: true})
        .bundle()
        .pipe(source('app.js'))
        .pipe(buffer())
        .pipe(cachebust.resources())
        .pipe(sourcemaps.init({loadMaps: true}))
        .pipe(uglify())
        .on('error', gutil.log)
        .pipe(sourcemaps.write('./'))
        .pipe(gulp.dest('./dist/js'));
});

gulp.task('build-css', ['clean'], function() {
    return gulp.src('./app/styles/style.scss')
        .pipe(sourcemaps.init())
        .pipe(sass().on('error', sass.logError))
        .pipe(cachebust.resources())
        .pipe(sourcemaps.write('./'))
        .pipe(gulp.dest('./dist/styles'));
});

gulp.task('build', ['clean', 'build-css', 'build-js'], function () {
    return gulp.src('./app/index.html')
        .pipe(cachebust.references())
        .pipe(gulp.dest('./dist'));
});

gulp.task('watch', function () {
    gulp.watch('app/**/*', ['build'])
});

gulp.task('webserver', ['build'], function () {
    gulp.src('./dist')
        .pipe(webserver({
            livereload: true,
            open: "http://localhost:8000/"
        }));
});

gulp.task('dev', ['watch', 'webserver']);
