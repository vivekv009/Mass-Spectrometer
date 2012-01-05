class AddEnabledToDatabases < ActiveRecord::Migration
  def change
    add_column :databases, :enabled, :boolean, {:default => true }
  end
end
