$(document).ready(function () {
    var loaderFadeOutTime = 500;
    var loaderTime = 1500;
    var lookbookFadeInTime = 1000;

    function startSlideshow() {
        $('#lookbook-loader').fadeOut(loaderFadeOutTime, function () {
            $(this).remove();
            $('#lookbook').fadeIn(lookbookFadeInTime);
        });
    }

    setTimeout(function() { startSlideshow(); }, loaderTime);
});
