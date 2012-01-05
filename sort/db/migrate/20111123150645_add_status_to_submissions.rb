class AddStatusToSubmissions < ActiveRecord::Migration
  def change
    add_column :submissions, :status, "char(1)", :default => "w"
  end
end
