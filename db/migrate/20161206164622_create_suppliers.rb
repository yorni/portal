class CreateSuppliers < ActiveRecord::Migration
  def change
    create_table :suppliers do |t|
      t.integer :code, limit: 4
      t.string :name, limit: 50
      t.index :code
      t.timestamps null: false
    end
  end
end
