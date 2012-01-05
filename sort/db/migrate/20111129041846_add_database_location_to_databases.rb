class AddDatabaseLocationToDatabases < ActiveRecord::Migration
  def change
    add_column :databases, :database_location, :string
  end
end
