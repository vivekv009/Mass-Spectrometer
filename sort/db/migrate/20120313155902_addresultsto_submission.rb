class AddresultstoSubmission < ActiveRecord::Migration
  def up
    add_column :submissions, :results_file, :string
    add_column :submissions, :send_confirmation, :boolean, :default => true
    add_column :submissions, :output_type, :string

  end

  def down
    remove_column :submissions, :results_file
    remove_column :submissions, :send_confirmation
    remove_column :submissions, :output_type
  end
end
