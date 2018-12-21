const gulp      = require('gulp');
const coffee    = require('gulp-coffee');
const chug      = require('gulp-chug');
const log       = require('fancy-log');

// get arguments with '--'
args = []
for (var i = 0, argv = process.argv, len = argv.length; i < len; ++i)
    if (argv[i].startsWith('--'))
        args.push(argv[i])

/* compile gulp-file.coffee */
compileRunGulp = function () {
    return gulp.src('gulp-file.coffee')
        .pipe(coffee({
            bare: true
        }))
        .pipe(chug({
            args: args
        }))
        .on('error', log.error)
};

// default task
gulp.task('default', compileRunGulp);