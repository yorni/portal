class OrderProductsController < ApplicationController

  def index
    order = Order.select(:id, :date_st, :date_fn, :date_sa).where(id: params[:order_id]).first
    $ghOrder = { id: order.id, date_st: order.date_st, date_fn: order.date_fn, date_sa: order.date_sa }

    @order_products = OrderProduct.where(order_id: $ghOrder[:id])
  end

  def update
    OrderProduct.where(id: params[:id]).update_all(count_pr: params[:order_product][:count_pr])
  end

  # Веб-сервис отправки заявки
  def send_order
    @order_products = OrderProduct.where(order_id: $ghOrder[:id]).where.not(count_pr: 0)
    date_st = $ghOrder[:date_st]

    a = []
    @order_products.each do |order_product|
      a << {"ins0:Product_id" => order_product.product.code,  "ins0:Date" => order_product.date, "ins0:Count_po" => "#{order_product.count_pr}"}
    end

    message = {"CreateRequest" => {"ins0:Institutions_id" => $ghInstitution[:code], "ins0:DateStart" => date_st.strftime("%Y-%m-%d"), "ins0:DateFinish" => $ghOrder[:date_fn].strftime("%Y-%m-%d"), "ins0:TMC" => a}}
    require 'savon'
    client = Savon.client( wsdl: $ghSavon[:wsdl], namespaces:  $ghSavon[:namespaces] )
    response = client.call( :СreationАpplication_units, message: message)

    interface_state = response.body[:СreationАpplication_units_response][:return][:interface_state]
    respond = response.body[:СreationАpplication_units_response][:return][:respond]

    if interface_state == 'OK' then
      Order.where(id: $ghOrder[:id]).update_all(date_sa: Date.today)
      redirect_to orders_path
    end
  end

end
