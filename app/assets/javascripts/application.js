// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require jquery-ui
//= require jquery-ui/datepicker-uk
//= require jquery.ui.monthpicker
//= require_tree .

$( document ).on('turbolinks:load', function() {
  $.monthpicker.initialized = false;

  // Выделить ячейку
  $('.row-hover tbody tr').click(function(e){
      $(this).addClass('row-click').siblings().removeClass('row-click');
  });

  // Про потери фокуса сохраняем значение
  $('.blur-submit').blur( function() {
    if ( parseFloat($(this).data( 'oldValue')) != parseFloat($(this).val()) ) {
      $(this).parent('form').submit();
    };
  });

  // Про получении фокуса выделяем весь текс
  $('input[type="number"]').focus( function() {
    $(this).data( 'oldValue', $(this).val() );
    $(this).select();
  });

});




