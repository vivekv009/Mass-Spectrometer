class AddDatabasesIdToDatabaseVersions < ActiveRecord::Migration
  def change
    add_column :database_versions, :database_id, :integer
  end
end
