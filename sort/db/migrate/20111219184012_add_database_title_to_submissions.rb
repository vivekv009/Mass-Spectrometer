class AddDatabaseTitleToSubmissions < ActiveRecord::Migration
  def change
    add_column :submissions, :database_title, :string
  end
end
