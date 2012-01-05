# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do

  factory :fixed_submission_protein_mod, :class => "SubmissionProteinMod" do 
   association :submission 
   association :protein_mod
   category "fixed"
  end
  
  factory :variable_submission_protein_mod, :class => "SubmissionProteinMod" do 
   association :submission 
   association :protein_mod
   category "variable"
  end

end