$( document ).on('turbolinks:load', function() {

  $( "#dialog-message" ).dialog({
    modal: true,
    buttons: {
      Ok: function() {
        $( this ).dialog( "close" );
      }
    }
  });

  // Настройка контрола
  $(".dp-date-min").each( function() {
    $(this).datepicker({
      minDate: new Date($(this).attr('data-min')),
      maxDate: new Date($(this).attr('data-max')),
      onSelect: function() {
        var dateValue  = $(this).datepicker( "getDate" );
        var dpDateMax = $(this).siblings('.dp-date-max');
        if (dateValue > dpDateMax.datepicker( "getDate" )) dpDateMax.val($(this).val());
        dpDateMax.attr('data-min', $.datepicker.formatDate('yy-mm-dd', dateValue));
        dpDateMax.datepicker("option", "minDate", dateValue);
      }
    });
  });

  // Настройка контрола
  $(".dp-date-max").each( function() {
    $(this).datepicker({
      minDate: new Date($(this).attr('data-min')),
      maxDate: new Date($(this).attr('data-max'))
    });
  });

 // Настройка контрола
  $(".dp-month-year").each( function() {
    $(this).monthpicker({
      changeYear: true,
      prevText: 'Попередній', // Display text for previous month link
      nextText: 'Наступний', // Display text for next month link
      monthNamesShort: ['Січень','Лютий','Березень','Квітень','Травень','Червень', 'Липень','Серпень','Вересень','Жовтень','Листопад','Грудень'],
      monthNames: ['Січень','Лютий','Березень','Квітень','Травень','Червень', 'Липень','Серпень','Вересень','Жовтень','Листопад','Грудень'],
      dateFormat: 'MM yy',
      minDate: new Date($(this).attr('data-min')),
      maxDate: new Date($(this).attr('data-max')),
      onSelect: function() {
        var dateValue  = $.datepicker.formatDate('yy-mm-dd', $(this).monthpicker( "getDate" ));
        if ($(this).attr('data-value') != dateValue) {
          $(this).attr('data-value', dateValue);
          $(this).siblings('.dp-my-date').val(dateValue);
          $(this).prop('disabled', true);
          $(this).parent('form').submit();
        };
      }
    });

    $(this).monthpicker( "setDate", new Date($(this).attr('data-value')) );
  });

});