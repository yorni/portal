class ChangeCodeTypeInBranches < ActiveRecord::Migration
  def change
    change_column :branches, :code, :string, limit: 4
  end
end
