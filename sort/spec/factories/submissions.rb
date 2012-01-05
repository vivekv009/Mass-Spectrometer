# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :submission do
    
      #file_location ""
			result ""
			file_extension "txt"
      #title "Test Submission"
      title {FactoryGirl.generate :sub_title }
      precursor_mass_tolerance 2.3
      l_bound_precursor 2
      u_bound_precursor 5
      min_charge 6
      max_missed_cleavages 8
      hitlist_max_length 4
      e_value_cutoff 11
      product_mass_tolerance 5.2
      fract_prod_peaks 3.5
      peak_cutoff 18.4
      max_var_mods 1
      association :ion_1
      association :ion_2
      association :enzyme
      association :database_version #, :file => dbfile
      association :user

      
      after_build { |submission|
        puts "after build"
        submission.fixed_protein_mods << FactoryGirl.create(:protein_mod)
        submission.fixed_protein_mods << FactoryGirl.create(:protein_mod)
        submission.variable_protein_mods << FactoryGirl.create(:protein_mod)
        submission.variable_protein_mods << FactoryGirl.create(:protein_mod)
        }
      
      
  end
  
   
end

FactoryGirl.define do
  sequence :sub_title do |t| "Test Submission #{t}" end
end

