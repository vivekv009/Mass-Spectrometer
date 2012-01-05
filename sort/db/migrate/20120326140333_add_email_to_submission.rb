class AddEmailToSubmission < ActiveRecord::Migration
  def change
    add_column :submissions, :email, :boolean, {:default => true }
  end
end
