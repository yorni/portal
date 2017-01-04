class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.belongs_to :institution, index: true, foreign_key: true
      t.date :date_st
      t.date :date_fn
      t.date :date_sa

      t.timestamps null: false
    end
  end
end
