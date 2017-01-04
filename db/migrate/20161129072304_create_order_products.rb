class CreateOrderProducts < ActiveRecord::Migration
  def change
    create_table :order_products do |t|
      t.belongs_to :order, index: true, foreign_key: true
      t.belongs_to :product, index: true, foreign_key: true
      t.date :date
      t.decimal :count_pr, precision: 8, scale: 2

      t.timestamps null: false
    end
  end
end
