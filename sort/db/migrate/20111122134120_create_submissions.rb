class CreateSubmissions < ActiveRecord::Migration
  def change
    create_table :submissions do |t|
      t.string :title
      t.string :file_location

      t.timestamps
    end
  end
end
