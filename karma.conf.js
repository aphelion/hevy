module.exports = function(config) {
    config.set({
        browsers: ['PhantomJS'],
        frameworks: ['jasmine-jquery', 'jasmine'],
        files: [
            'dist/js/app.*.js',
            'node_modules/angular-mocks/angular-mocks.js',
            'test/**/*.spec.js'
        ]
    });
};
