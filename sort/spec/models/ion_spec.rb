require 'spec_helper'

describe Ion do
  it "Factory should be valid" do
    @ion = FactoryGirl.create :ion_1
    @ion.should be_valid
  end

end
