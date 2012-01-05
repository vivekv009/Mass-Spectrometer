class RemoveDatabaseNameFromSubmissions < ActiveRecord::Migration
  def up
    remove_column :submissions, :database_name
  end

  def down
    add_column :submissions, :database_name, :string
  end
end
