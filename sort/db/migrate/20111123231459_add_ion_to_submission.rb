class AddIonToSubmission < ActiveRecord::Migration
  def change
    add_column :submissions, :max_missed_cleavages, :integer
    add_column :submissions, :hitlist_max_length, :integer
    add_column :submissions, :e_value_cutoff, :integer
    add_column :submissions, :max_var_mods, :integer
    add_column :submissions, :precursor_mass_tolerance, :float
    add_column :submissions, :product_mass_tolerance, :float
    add_column :submissions, :precursor_mass_search_type, :string
    add_column :submissions, :product_mass_search_type, :string
    add_column :submissions, :l_bound_precursor, :integer
    add_column :submissions, :u_bound_precursor, :integer
    add_column :submissions, :min_charge, :integer
    add_column :submissions, :fract_prod_peaks, :float
    add_column :submissions, :peak_cutoff, :float
    add_column :submissions, :ints_peaks, :integer
    add_column :submissions, :ion_1_id, :integer
    add_column :submissions, :ion_2_id, :integer
  end
end
