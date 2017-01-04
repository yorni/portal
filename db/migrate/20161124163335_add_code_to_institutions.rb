class AddCodeToInstitutions < ActiveRecord::Migration
  def change
    add_column :institutions, :code, :integer, limit: 9
    change_column :products, :code, :string, limit: 9
  end
end
