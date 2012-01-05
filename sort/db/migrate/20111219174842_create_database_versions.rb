class CreateDatabaseVersions < ActiveRecord::Migration
  def change
    create_table :database_versions do |t|
      t.string :file

      t.timestamps
    end
  end
end
