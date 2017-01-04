class AddCodeToBranches < ActiveRecord::Migration
  def change
    add_column :branches, :code, :integer, limit: 9
  end
end
