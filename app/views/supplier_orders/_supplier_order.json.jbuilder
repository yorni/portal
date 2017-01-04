json.extract! supplier_order, :id, :branch_id, :supplier_id, :number, :date, :date_st, :date_fn, :created_at, :updated_at
json.url supplier_order_url(supplier_order, format: :json)