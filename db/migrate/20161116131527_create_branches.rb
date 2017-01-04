class CreateBranches < ActiveRecord::Migration
  def change
    create_table :branches do |t|
      t.string :name, limit: 30

      t.timestamps null: false
    end
  end
end
