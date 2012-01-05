class CreateIons < ActiveRecord::Migration
  def change
    create_table :ions do |t|
      t.string :name

      t.timestamps
    end
    
  end
end
