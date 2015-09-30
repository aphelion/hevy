$(document).ready(function () {
    var minDelay = 1500;
    var start = new Date();
    var lookbook = $('#lookbook');
    if(lookbook.length) {
        $(document).on('init.slides', function () {
            var end = new Date();
            var timeInMilliseconds = end - start;

            function startSlideshow() {
                $('#lookbook-spinner').fadeOut(500, function () {
                    $(this).remove();
                    $('#lookbook').fadeIn(1000);
                });
            }

            if (timeInMilliseconds  < minDelay) {
                setTimeout(function() { startSlideshow(); }, minDelay - timeInMilliseconds);
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
            $(this).superslides('animate', 'next');
            $(this).superslides('stop');
        });

        lookbook.hammer().on('swiperight', function () {
            $(this).superslides('animate', 'prev');
            $(this).superslides('stop');
        });
    }
});
