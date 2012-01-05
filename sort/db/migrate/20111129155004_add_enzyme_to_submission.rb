class AddEnzymeToSubmission < ActiveRecord::Migration
  def change
    add_column :submissions, :enzyme_id, :integer
  end
end
