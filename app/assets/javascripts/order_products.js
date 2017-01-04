$( document ).on('turbolinks:load', function() {

  // Про потери фокуса сохраняем значение
  $('.op_cell').blur( function() {
    $(this).parent('form').submit();
  });

  // Про получении фокуса выделяем весь текс
  $('.op_cell').focus( function() {
      $(this).select();
  });

});