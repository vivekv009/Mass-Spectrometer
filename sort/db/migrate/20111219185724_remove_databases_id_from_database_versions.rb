class RemoveDatabasesIdFromDatabaseVersions < ActiveRecord::Migration
  def up
    remove_column :database_versions, :database_id
  end

  def down
    add_column :database_versions, :database_id, :integer
  end
end
