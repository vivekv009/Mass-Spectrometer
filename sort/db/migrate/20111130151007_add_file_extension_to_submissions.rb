class AddFileExtensionToSubmissions < ActiveRecord::Migration
  def change
    add_column :submissions, :file_extension, :string
    remove_column :submissions, :file_location
  end
end
