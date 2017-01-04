$( document ).on('turbolinks:load', function() {
    $('.rp_cell').blur(function() {
        $(this).parent('form').submit();
        var perent = $(this).closest('tr');

        var plan = parseFloat(perent.children('.col-plan').html());
        var fact = parseFloat($(this).val());
        var dif = (fact-plan).toFixed(2)
        var colDiff = perent.children('.col-diff');

        colDiff.html(dif);

        if ( dif == 0 ) {
          colDiff.removeClass('col-diff-plus');
          colDiff.removeClass('col-diff-minus');
        }
        else {
          if ( dif > 0 ) {
            colDiff.removeClass('col-diff-minus');
            colDiff.addClass('col-diff-plus');
          }
          else {
            colDiff.removeClass('col-diff-plus');
            colDiff.addClass('col-diff-minus');
          };
        };

    });
});