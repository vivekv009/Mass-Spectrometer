class AddEnablesToDatabaseVersions < ActiveRecord::Migration
  def change
    add_column :database_versions, :enabled, :boolean, {:default => true }
  end
end
