class OrdersController < ApplicationController

  # Веб-сервис загрузки графика
  def get_schedule

    date_st = params[:date_st].to_date.strftime('%Y-%m-%d')
    date_fn = params[:date_fn].to_date.strftime('%Y-%m-%d')

    message = { "GetRequest" => { "ins0:StartDate" => date_st, "ins0:EndDate" => date_fn, "ins0:DepartmentsCode" => $ghInstitution[:code] } }
    require 'savon'
    client = Savon.client( wsdl: $ghSavon[:wsdl], namespaces: $ghSavon[:namespaces] )
    response = client.call( :get_schedule_of_food_supply, message: message )

    interface_state = response.body[:get_schedule_of_food_supply_response][:return][:interface_state]
    respond = response.body[:get_schedule_of_food_supply_response][:return][:food]

    if interface_state == 'OK' then
      if !respond.blank? then
        ###
        order = Order.new do |o|
          o.institution_id = $ghInstitution[:id]
          o.date_st = date_st
          o.date_fn = date_fn
          o.date_sa = ''
        end
        order.save

        a = []
        respond.each do |f|
          a << [{order_id: order.id, product_id: Product.select(:id).where(code: f[:code_of_food]).first.id, date: f[:date], description: f.include?(:comments) ? f[:comments] : '', count_pr: 0}]
        end

        OrderProduct.create!(a)

        $ghOrders[:date_filter] = params[:date_st].to_date

        redirect_to order_products_path(order_id: order.id)
      else
        error_text = 'За вибранний період з ' + params[:date_st] + ' по ' + params[:date_fn] + ' в графіку немає продуктів!'
      end
    else
      error_text = 'Web-сервіс не працює. Зверніться до адмніністратора!'
    end

    if !error_text.nil?
      $ghOrders.merge!(error_text: error_text)
      redirect_to orders_path
    end
  end

  def index
    get_ghInstitution(14)

    date_today = Date.today
    $ghOrders.merge!({date_filter: params[:date_filter].to_date}) unless params[:date_filter].blank?
    $ghOrders.merge!({date_filter: date_today}) if $ghOrders[:date_filter].blank?

    date_min = Order.select(:date_st).where(institution_id: $ghInstitution[:id]).minimum(:date_st)
    date_max = Order.select(:date_fn).where(institution_id: $ghInstitution[:id]).maximum(:date_fn)

    $ghOrders.merge!(date_min: date_min.nil? ? date_today.beginning_of_month : date_min.beginning_of_month, date_max: date_max.nil? ? date_today : date_max)

    @orders = Order.where(institution_id: $ghInstitution[:id], date_st: $ghOrders[:date_filter].beginning_of_month..$ghOrders[:date_filter].end_of_month).order(date_st: :desc)
  end

  def destroy
    Order.find(params[:id]).destroy
    redirect_to orders_url
  end

end
