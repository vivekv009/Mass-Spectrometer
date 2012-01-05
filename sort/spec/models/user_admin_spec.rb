require 'spec_helper'

describe User do
  before :each do
    #create one admin from users.rb inside factory's function
    @admin1 = FactoryGirl.create :admin
    @admin2 = FactoryGirl.create :admin
  end
  
  it "should run" do
    User.get_admins.length.should == 2
  end
  
end
