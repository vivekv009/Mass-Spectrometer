class AddErrorToSubmissions < ActiveRecord::Migration
  def change
    add_column :submissions, :error_message, :string
  end
end
