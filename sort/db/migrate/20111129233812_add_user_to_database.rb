class AddUserToDatabase < ActiveRecord::Migration
  def change
    add_column :databases, :user_id, :integer
  end
end
