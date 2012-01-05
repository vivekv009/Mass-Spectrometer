class AddDatabaseVersionIdToSubmission < ActiveRecord::Migration
  def change
    add_column :submissions, :database_version_id, :integer
  end
end
