# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    name                  "Example User"
    username              { FactoryGirl.generate :user_username }
    email                 { FactoryGirl.generate :user_email }
    password              "foobar"
    password_confirmation "foobar"
  end
end
FactoryGirl.define do
  sequence :user_username do |t|
    "foouser_#{t}"
  end
end
FactoryGirl.define do
  sequence :user_email do |t|
    "user#{t}@example.com"
  end
end
#function for creating admin factory!
FactoryGirl.define do
  factory :admin, :class => :user do
    name                  "Example Admin"
    username              { FactoryGirl.generate :admin_username }
    email                 { FactoryGirl.generate :admin_email }
    password              "foobar"
    password_confirmation "foobar"
    admin                 true
  end
end
FactoryGirl.define do
  sequence :admin_username do |t|
    "fooadmin_#{t}"
  end
end
FactoryGirl.define do
  sequence :admin_email do |t|
    "admin#{t}@example.com"
  end
end

