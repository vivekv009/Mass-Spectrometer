#require 'cucumber/rspec/doubles'
Given /^hard disk space is (high|low)$/ do |state|
  case state
    when "low"
      space = 5
    when "high"
      space = 555555
  end
  SubmissionsController.any_instance.stub(:space_available_mb).and_return(space)
  DatabasesController.any_instance.stub(:space_available_mb).and_return(space)
end


