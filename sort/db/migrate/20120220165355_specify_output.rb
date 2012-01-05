class SpecifyOutput < ActiveRecord::Migration
  def up
      add_column :submissions, :output_filetype, :string, :default => "1"
   end

  def down
  remove_column :submissions, :output_filetype
  end
end
