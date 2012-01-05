class CreateMassSearchTypes < ActiveRecord::Migration
  def change
    create_table :mass_search_types do |t|
      t.string :name

      t.timestamps
    end
    change_column :submissions, :precursor_mass_search_type, :integer
    change_column :submissions, :product_mass_search_type, :integer
    
  end
end
