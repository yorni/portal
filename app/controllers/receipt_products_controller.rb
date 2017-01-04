class ReceiptProductsController < ApplicationController

  def index
    receipt = Receipt.select(:id, :supplier_id, :date, :date_sa).where(id: params[:receipt_id]).first
    $ghReceipt = { id: receipt.id, supplier_name: receipt.supplier.name, suppleir_code: receipt.supplier.code, date: receipt.date, date_sa: receipt.date_sa }

    @receipt_products = ReceiptProduct.where(receipt_id: $ghReceipt[:id])
  end

  def update
    ReceiptProduct.where(id: params[:id]).update_all(count_fact: params[:receipt_product][:count_fact])
  end

  # Веб-сервис отправки поступления
  def send_receipt
    @receipt_products = ReceiptProduct.where(receipt_id: $ghReceipt[:id]).where.not(count_fact: 0)

    a = []
    @receipt_products.each do |receipt_product|
      a << {"ins0:CodeOfGoods" => receipt_product.product.code,  "ins0:Quantity" => "#{receipt_product.count_fact}"}
    end

    message = {"GetRequest" => {"ins0:Supplier_id" => $ghReceipt[:suppleir_code], "ins0:Institutions_id" => $ghInstitution[:code], "ins0:Goods" => a}}
    require 'savon'
    client = Savon.client( wsdl: $ghSavon[:wsdl], namespaces:  $ghSavon[:namespaces] )
    response = client.call( :create_doc_supply_goods, message: message)

    interface_state = response.body[:create_doc_supply_goods_response][:return][:interface_state]
    respond = response.body[:create_doc_supply_goods_response][:return][:respond]

    if interface_state == 'OK' then
      Receipt.where(id: $ghReceipt[:id]).update_all(date_sa: Date.today)
      redirect_to receipts_path
    end
  end

end