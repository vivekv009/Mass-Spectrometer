class AddFileToSubmission < ActiveRecord::Migration
  def change
    add_column :submissions, :file, :string
	  add_column :submissions, :result, :string, {:default => nil }
  end
end
