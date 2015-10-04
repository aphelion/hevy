$(document).ready(function () {
    $('[data-background-image-url]').each(function () {
        var image = $(this).attr('data-background-image-url');
        if (typeof image !== typeof undefined && image !== false) {
            $(this).css('background-image', 'url(' + image + ')');
        }
    });

    $('.product').hover(function () {
        $(this).find('.product-image-secondary').fadeToggle(200);
    });

    $('.product-page .product-image-option').click(function () {
        var productImage = $('.product-page .product-image');
        var activeProductOption = $(this);
        var oldImageUrlString = productImage.css('background-image');
        var newImageUrlString = 'url(' + activeProductOption.attr('data-background-image-url') + ')';
        if (oldImageUrlString !== newImageUrlString) {
            $('.product-page .product-image-option.active').removeClass('active');
            activeProductOption.addClass('active');
            productImage.stop().fadeTo(250, 0, function () {
                $(this).css('background-image', 'url(' + activeProductOption.attr('data-background-image-url') + ')')
                    .fadeTo(250, 1);
            });
        }
    })
});
