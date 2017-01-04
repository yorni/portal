class CreateReceipts < ActiveRecord::Migration
  def change
    create_table :receipts do |t|
      t.belongs_to :institution, index: true, foreign_key: true
      t.belongs_to :supplier, index: true, foreign_key: true
      t.date :date

      t.timestamps null: false
    end
  end
end
