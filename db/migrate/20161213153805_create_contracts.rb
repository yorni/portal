class CreateContracts < ActiveRecord::Migration
  def change
    create_table :contracts do |t|
      t.string :number, limit: 12
      t.date :date

      t.timestamps null: false
    end
  end
end
