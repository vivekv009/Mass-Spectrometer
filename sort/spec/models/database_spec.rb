  require 'spec_helper'

describe Database do

  
  it { should belong_to :user}  

  # association between a database and databaseVersions
  it {should have_many(:database_versions) }

  # checking the exsistence of the databse title 
  it "should not accept a database upload without a database title" do 
    d = FactoryGirl.build :database, :title => ''
    d.should_not be_valid
  end 

  # checking the uniquencess of the databse title 
  it "should not accept a duplicate databasebase title" do 
    submitted_database= FactoryGirl.create :database
    submitted_database2= FactoryGirl.create :database2
    submitted_database.title.should_not ==  submitted_database2.title
  end
  

end 
