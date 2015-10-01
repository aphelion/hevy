$(document).ready(function () {
    var spinnerFadeOutTime = 500;
    var minSpinnerTime = 1500;
    var lookbookFadeInTime = 1000;

    var start = new Date();
    var lookbook = $('#lookbook');

    function setManualMode(lookbook) {
        lookbook.superslides('stop');
        lookbook.data('superslides').animation = lookbook.data('superslides').fx['slide'];
    }

    if(lookbook.length) {
        $(document).on('init.slides', function () {
            var end = new Date();
            var timeInMilliseconds = end - start;

            function startSlideshow() {
                $('#lookbook-spinner').fadeOut(spinnerFadeOutTime, function () {
                    $(this).remove();
                    lookbook.fadeIn(lookbookFadeInTime);
                });
            }

            if (timeInMilliseconds  < minSpinnerTime) {
                setTimeout(function() { startSlideshow(); }, minSpinnerTime - timeInMilliseconds);
            } else {
                startSlideshow();
            }
        });

        lookbook.superslides({
            play: 5000,
            animation: 'fade',
            inherit_height_from: '#lookbook-container',
            pagination: false
        });

        lookbook.hammer().on('swipeleft', function () {
            setManualMode($(this));
            $(this).superslides('animate', 'next');
        });

        lookbook.hammer().on('swiperight', function () {
            setManualMode($(this));
            $(this).superslides('animate', 'prev');
        });
    }
});
