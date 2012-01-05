class AddSubmissionDefaults < ActiveRecord::Migration
  def up
    change_column :submissions, :max_missed_cleavages, :integer, {:default => 1 }
    change_column :submissions, :hitlist_max_length, :integer, {:default => 10 }
    change_column :submissions, :e_value_cutoff, :integer, {:default => 1 }
    change_column :submissions, :max_var_mods, :integer, {:default => 64 }
    change_column :submissions, :precursor_mass_tolerance, :float, {:default => 2 }
    change_column :submissions, :product_mass_tolerance, :float, {:default => 0.8 }
    change_column :submissions, :precursor_mass_search_type, :integer, {:default => 2 }
    change_column :submissions, :product_mass_search_type, :integer, {:default => 1 }
    change_column :submissions, :l_bound_precursor, :integer, {:default => 1 }
    change_column :submissions, :u_bound_precursor, :integer, {:default => 6 }
    change_column :submissions, :min_charge, :integer, {:default => 7 }
    change_column :submissions, :fract_prod_peaks, :float, {:default => 0.95 }
    change_column :submissions, :peak_cutoff, :float, {:default => 0 }
    change_column :submissions, :ints_peaks, :integer, {:default => 20 }
    change_column :submissions, :ion_1_id, :integer, {:default => 3 }
    change_column :submissions, :ion_2_id, :integer, {:default => 5 }
    change_column :submissions, :enzyme_id, :integer, {:default => 1 }
  end

  def down
    change_column :submissions, :max_missed_cleavages, :integer
    change_column :submissions, :hitlist_max_length, :integer
    change_column :submissions, :e_value_cutoff, :integer
    change_column :submissions, :max_var_mods, :integer
    change_column :submissions, :precursor_mass_tolerance, :float
    change_column :submissions, :product_mass_tolerance, :float
    change_column :submissions, :precursor_mass_search_type, :integer
    change_column :submissions, :product_mass_search_type, :integer
    change_column :submissions, :l_bound_precursor, :integer
    change_column :submissions, :u_bound_precursor, :integer
    change_column :submissions, :min_charge, :integer
    change_column :submissions, :fract_prod_peaks, :float
    change_column :submissions, :peak_cutoff, :float
    change_column :submissions, :ints_peaks, :float
    change_column :submissions, :ion_1_id, :integer
    change_column :submissions, :ion_2_id, :integer
    change_column :submissions, :enzyme_id, :integer
  end
end
