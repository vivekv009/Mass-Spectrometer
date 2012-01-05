# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do   
    factory :database_version,  :class => "DatabaseVersion" do
     #file "MyString"
    file File.open(Rails.root.join("features/sequence_library/valid_database2.fasta"))
     database_title "title_1"
     #database_id "1"
     #database FactoryGirl.build :database
     association :database
     #database_title {FactoryGirl.next(:database_title)}
    end
   
 #uncomment to work with different versions names   
   # FactoryGirl.sequence :database_title do |t|
    #  "somefile_#{t}"    
end
