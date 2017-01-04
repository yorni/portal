class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :code, limit: 20
      t.string :name, limit: 50

      t.timestamps null: false
    end
  end
end
