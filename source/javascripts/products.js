$(document).ready(function () {
    $( '.product-image' ).each(function() {
        var attr = $(this).attr('data-image-url');

        if (typeof attr !== typeof undefined && attr !== false) {
            $(this).css('background-image', 'url('+attr+')');
        }
    });
});
