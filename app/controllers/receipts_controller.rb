class ReceiptsController < ApplicationController

  # Создание поступления
  def create

    institution_id = 14
    supplier_order_id = params[:supplier_order_id]
    contract_number = params[:contract_number]
    invoice_number = params[:invoice_number]

    receipt_id = 0
    SupplierOrder.where(id: supplier_order_id).first.so_products.order(:date).each_with_index do |so_product, index_sop|

      receipt_id = Receipt.create!(institution_id: institution_id, supplier_order_id: supplier_order_id, contract_number: contract_number,
                                invoice_number: invoice_number, date: Date.today.strftime("%Y-%m-%d")).id if index_sop == 0

      ReceiptProduct.create!(date: so_product.date, receipt_id: receipt_id, product_id: so_product.product_id, count_fact: so_product.count)
    end

    redirect_to products_receipts_path(receipt_id: receipt_id)
  end


  def index
    @supplier_orders = SupplierOrder.all
    @receipts = Receipt.where(supplier_order_id: @supplier_orders.first.id)
  end

  def ajax_get_receipts_for_table
    @receipts = Receipt.where(supplier_order_id: params[:supplier_order_id])
    @contracts = SoProduct.select(:contract_number).distinct(:contract_number).where(supplier_order_id: params[:supplier_order_id] )
  end

  def destroy
    Receipt.find(params[:id]).destroy
    redirect_to receipts_url
  end

  def products
    @receipt_products = ReceiptProduct.where(receipt_id: params[:receipt_id]).order(:date)
    @receipt = @receipt_products.first.receipt
  end

  # Обновление количество
  def products_update
    ReceiptProduct.where(id: params[:receipt_product_id]).update_all(count_fact: params[:count_fact])
  end

  def ajax_get_supplier_orders_for_select
    @supplier_orders = SupplierOrder.where(supplier_id: params[:supplier_id])
  end

  def ajax_get_contracts_for_select
    @contracts = SoProduct.select(:contract_number).distinct(:contract_number).where(supplier_order_id: params[:supplier_order_id] )
  end

  # Веб-сервис отправки поступления
  def send_sa
    @receipt_products = ReceiptProduct.where(receipt_id: params[:receipt_id]).where.not(count_fact: 0)

    @receipt = @receipt_products.first.receipt

    date_send = Date.today

    a = []
    @receipt_products.each do |receipt_product|
      a << {"ins0:CodeOfGoods" => receipt_product.product.code,  "ins0:Quantity" => receipt_product.count_fact}
    end

    message = {"GetRequest" => {"ins0:Institutions_id" => @receipt.institution.code,
                                "ins0:InvoiceNumber" => @receipt.invoice_number,
                                "ins0:ContractNumber" => @receipt.contract.number,
                                "ins0:OrderNumber" => @receipt.supplier_order.number,
                                "ins0:Date" => date_send,
                                "ins0:Goods" => a}}

    require 'savon'
    client = Savon.client( wsdl: $ghSavon[:wsdl], namespaces:  $ghSavon[:namespaces] )
    response = client.call( :create_doc_supply_goods, message: message)

    interface_state = response.body[:create_doc_supply_goods_response][:return][:interface_state]
    respond = response.body[:create_doc_supply_goods_response][:return][:respond]

    render text: message

    if interface_state == 'OK' then
      Receipt.where(id: $ghReceipt[:id]).update_all(date_sa: Date.today)
      redirect_to receipts_path
    end
  end


end
