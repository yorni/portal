class CreateSupplierOrders < ActiveRecord::Migration
  def change
    create_table :supplier_orders do |t|
      t.belongs_to :branch, index: true, foreign_key: true
      t.belongs_to :supplier, index: true, foreign_key: true
      t.string :number, limit: 12
      t.date :date
      t.date :date_st
      t.date :date_fn

      t.timestamps null: false
    end
  end
end
