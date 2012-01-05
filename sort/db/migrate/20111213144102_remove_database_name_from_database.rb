class RemoveDatabaseNameFromDatabase < ActiveRecord::Migration
  def up
    remove_column :databases, :database_name
  end

  def down
    add_column :databases, :database_name, :string
  end
end
