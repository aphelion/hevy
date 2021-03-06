$(document).ready(function () {
    // responsive, aspect-ratio constrained image setup
    $('[data-background-image-url]').each(function () {
        var image = $(this).attr('data-background-image-url');
        if (typeof image !== typeof undefined && image !== false) {
            $(this).css('background-image', 'url(' + image + ')');
        }
    });

    // product page hover animation
    $('.product').hover(function () {
        $(this).find('.product-image-secondary').stop().fadeToggle(250);
    });

    // products page image selection animation
    $('.product-page .product-image-selector').click(function () {
        var newImageSelector = $(this);
        var productImageNext = $('.product-page .product-image-option[data-background-image-url="'
            + newImageSelector.attr('data-background-image-url')
            + '"]');
        var productImageCurrent = $('.product-page .product-image-current');
        var oldImageUrlString = productImageCurrent.css('background-image');
        var newImageUrlString = productImageNext.css('background-image');

        if (oldImageUrlString !== newImageUrlString) {
            $('.product-page .product-image-selector.active').removeClass('active');
            newImageSelector.addClass('active');
            productImageNext
                .stop()
                .fadeTo(500, 1, function () {
                    productImageCurrent.css('background-image', newImageUrlString);
                    $(this).hide();
                });
        }
    });
});
