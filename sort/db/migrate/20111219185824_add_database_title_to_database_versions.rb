class AddDatabaseTitleToDatabaseVersions < ActiveRecord::Migration
  def change
    add_column :database_versions, :database_title, :string
  end
end
