class SupplierOrdersController < ApplicationController
  def index
    date_today = Date.today
    $ghSupplier_order.merge!(date_filter: params[:date_filter].to_date) unless params[:date_filter].blank?
    $ghSupplier_order.merge!(date_filter: date_today) if $ghOrders[:date_filter].blank?

    date_min = SupplierOrder.select(:date).where(institution_id: $ghInstitution[:id]).minimum(:date)
    date_max = SupplierOrder.select(:date).where(institution_id: $ghInstitution[:id]).maximum(:date)

    $ghSupplier_order.merge!(date_min: date_min.nil? ? date_today.beginning_of_month :  date_min.beginning_of_month, date_max: date_max.nil? ? date_today :  date_max)

    @supplier_orders = SupplierOrder.where(institution_id: $ghInstitution[:id], date_st: $ghSupplier_order[:date_filter].beginning_of_month..$ghSupplier_order[:date_filter].end_of_month).order(date: :desc)
  end

  # Создание заявки по входящим данным (Веб-сервис)
  def create_so
    params_so = params[:supplier_order]
    params_so_products = params_so[:so_products]

    supplier = get_supplier_id(params_so[:supplier_code])
    branch = get_branch_id(params_so[:branch_code])

    error = {}

    error.merge!(supplier: supplier[:error]) if !supplier[:error].nil?
    error.merge!(branch: branch[:error]) if !branch[:error].nil?

    if error.blank? then
      supplier_orders = SupplierOrder.new(supplier_id: supplier[:id], branch_id: branch[:id], number: params_so[:number],
                        date: Time.at(params_so[:date].to_i).strftime('%Y-%m-%d'), date_st: Time.at(params_so[:date_st].to_i).strftime('%Y-%m-%d'),
                        date_fn: Time.at(params_so[:date_fn].to_i).strftime('%Y-%m-%d'))
      supplier_orders.save

      error_so_product = []

      params_so_products.each do |p_sop|
        institution = get_institution_id(p_sop[:institution_code])
        contract = get_contract_id(p_sop[:contract_number])
        product = get_product_id(p_sop[:product_code])

        error = {}
        error.merge!(institution: institution[:error]) if !institution[:error].nil?
        error.merge!(contract: contract[:error]) if !contract[:error].nil?
        error.merge!(product: product[:error]) if !product[:error].nil?

        if error.blank?
          SoProduct.create!(supplier_order_id: supplier_orders.id, institution_id: institution[:id], product_id: product[:id],contract_id: contract[:id], date: Time.at(p_sop[:date].to_i).strftime('%Y-%m-%d'), count: p_sop[:count])
        else
          error_so_product << [error]
        end
      end

      result = {result: true}
      result.merge!(error: error_so_product) if !error_so_product.blank?
    else
      result =  {result: false, error: error}
    end

    render json: result
  end

end
