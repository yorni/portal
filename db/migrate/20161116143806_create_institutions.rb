class CreateInstitutions < ActiveRecord::Migration
  def change
    create_table :institutions do |t|
      t.string :name, limit: 50
      t.belongs_to :branch, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
