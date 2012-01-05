class AddDatabaseToSubmission < ActiveRecord::Migration
  def change
    add_column :submissions, :database_name, :string
  end
end
