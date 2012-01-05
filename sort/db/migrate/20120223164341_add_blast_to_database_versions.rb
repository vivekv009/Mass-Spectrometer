class AddBlastToDatabaseVersions < ActiveRecord::Migration
  def change
    add_column :database_versions, :processed, :boolean, :default => 0
    add_column :database_versions, :error_message, :string
  end
end
