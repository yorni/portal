class CreateSoProducts < ActiveRecord::Migration
  def change
    create_table :so_products do |t|
      t.belongs_to :supplier_order, index: true, foreign_key: true
      t.belongs_to :institution, index: true, foreign_key: true
      t.belongs_to :product, index: true, foreign_key: true
      t.belongs_to :contract, index: true, foreign_key: true
      t.date :date
      t.decimal :count, precision: 8, scale: 2

      t.timestamps null: false
    end
  end
end
