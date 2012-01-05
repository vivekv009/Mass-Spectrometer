# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :ion_1, :class => "Ion"  do
      name "a"
      external_id 0
  end
end
FactoryGirl.define do  
  factory :ion_2, :class => "Ion" do
      name "c"
      external_id 2
  end
  
end
