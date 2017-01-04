$( document ).on('turbolinks:load', function() {

  /* Выделить ячейку */
  $('#main-receipts .row-hover tr').click(function(e){
    $.ajax({ url: $(this).data('ajax-path'), type: 'GET', dataType: "script" });
  });

  /* Выбор со списка договоров */
  $('#main-receipts-products .create-receipt #contract_number').change(function() { createReceiptSubmit(); });




  /* Выбор со списка поставщика */
  $('#main-receipts-products .create-receipt #supplier_id').change(function(e){
    if ( $(this).val() ) {
      var path_ajax = $(this).data('ajax-path')+'?supplier_id='+$(this).val();
      $.ajax({ url: path_ajax, type: 'GET', dataType: "script" });
    } else {
      $('#main-receipts-products .create-receipt #supplier_order_id').prop('disabled', true).prop('selectedIndex', 0);
      $('#main-receipts-products .create-receipt #contract_number').prop('disabled', true).prop('selectedIndex', 0);
      $('#main-receipts-products .create-receipt input[type="submit"]').prop('disabled', true);
    };
  });

  /* Выбор со списка заявки */
  $('#main-receipts-products .create-receipt #supplier_order_id').change(function(e){
    if ( $(this).val() ) {
      var path_ajax = $(this).data('ajax-path')+'?supplier_order_id='+$(this).val();
      $.ajax({ url: path_ajax, type: 'GET', dataType: "script" });
    } else {
      $('#main-receipts-products .create-receipt #contract_number').prop('disabled', true).prop('selectedIndex', 0);
       $('#main-receipts-products .create-receipt input[type="submit"]').prop('disabled', true);
    };
  });

  /* Выбор со списка договоров */
  $('#main-receipts-products .create-receipt #contract_number').change(function() { createReceiptSubmit(); });
  /* Ввод накладной */
  $('#main-receipts-products .create-receipt #invoice_number').keyup(function() { createReceiptSubmit(); });

  // Проверка то делать ли доступной кнопку для создания поступления
  function createReceiptSubmit(){
    if ( !$('#main-receipts-products .create-receipt #contract_number').val() ||
      $.trim($('#main-receipts-products .create-receipt #invoice_number').val()).length === 0 ) {
      $('#main-receipts-products .create-receipt input[type="submit"]').prop('disabled', true);
    } else {
      $('#main-receipts-products .create-receipt input[type="submit"]').prop('disabled', false);
    };
  };

});