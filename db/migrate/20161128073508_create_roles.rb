class CreateRoles < ActiveRecord::Migration
  def change
    create_table :roles do |t|
      t.string :name, limit: 15

      t.timestamps null: false
    end
  end
end
