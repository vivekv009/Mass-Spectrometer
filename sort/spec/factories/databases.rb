# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :database,  :class => "Database" do
      title {FactoryGirl.generate(:title)}
      database_location " "
      association :user
  end
end
FactoryGirl.define do
  factory :database2, :class => "Database"  do
      title {FactoryGirl.generate(:title)}
      database_location " "
      association :user
  end  
end

FactoryGirl.define do
  sequence :title do |t|
    "title_#{t}"
  end
end


