$(document).ready(function () {
    $('[class^="product-image"]').each(function () {
        var image = $(this).attr('data-image-url');
        if (typeof image !== typeof undefined && image !== false) {
            $(this).css('background-image', 'url(' + image + ')');
        }
    });

    $('.product').hover(function () {
        $(this).find('.product-image-secondary').fadeToggle(200);
    });
});
