class AddTitleToDatabases < ActiveRecord::Migration
  def change
    add_column :databases, :title, :string
  end
end
