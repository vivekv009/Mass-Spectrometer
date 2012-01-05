Given /^(\d+) (\w+) submission(?:s?) exist(?:s?)$/ do |hardwares, status|	
	file = Rack::Test::UploadedFile.new("features/uploads/valid_submission.txt", 'text/plain')
  hardwares.to_i.times { |i| o = FactoryGirl.create :submission, :title => "Submission #{status}_#{i + 1}", :status => status, :file => file, :user => @current_user
}
end

Given /^(\d+) (\w+) submission(?:s?) exist(?:s?) by another user$/ do |hardwares, status|	
	file = Rack::Test::UploadedFile.new("features/uploads/valid_submission.txt", 'text/plain')
  hardwares.to_i.times { |i| FactoryGirl.create :submission, :title => "Submission " + status + "_#{i + 1}", :status => status, :file => file, :user => FactoryGirl.create(:user)}
end

Then /^I should see the submission "([^"]*)" with status "([^"]*)"$/ do |submission, status|
	page.should have_content(submission)
	page.should have_content(status)
end

Then /^I should see the queued submissions$/ do		
	page.should have_content("Submission p_1")
	page.should have_content("Submission w_1")
	page.should have_content("Submission w_2")
	page.should_not have_content("Submission c_1")
	page.should_not have_content("Submission f_1")
end

Then /^I should see the submission results$/ do		
	page.should have_content("Submission c_1")
	page.should have_content("Submission c_2")
	page.should have_content("Submission c_3")
	page.should have_content("Submission c_4")
	page.should have_content("Submission f_1")
	page.should_not have_content("Submission p_1")
	page.should_not have_content("Submission w_1")
end

When /^I wait (\d+) seconds$/ do |seconds|
  sleep seconds.to_i
end

Given /^I fill in valid submission parameters$/ do
	@submission = FactoryGirl.build(:submission)
	fill_in('submission_title',:with => @submission.title)
	fill_in('submission_peak_cutoff',:with => @submission.peak_cutoff)
	fill_in('submission_precursor_mass_tolerance',:with => 1.0)
	fill_in('submission_product_mass_tolerance',:with => @submission.product_mass_tolerance)
	fill_in('submission_fract_prod_peaks',:with => @submission.fract_prod_peaks)
#  fill_in('submission_max_var_mods',:with => @submission.max_var_mods)
  page.select("1", :from => "submission_max_var_mods")

  ### Select the last items from the database dropdown boxes
  #step %{I select "title_1" from "submission_database"}
  #a = find_field('submission_database')
  #a.all('option').last.select_option()
  #
  #step %{I select "item1" from "submission_database_version_id"}
  save_and_open_page  
  fill_in('submission_database_version', :with => 1.0)
  #a.all('option', :text => "UTC").last.select_option()

end

Given /^I submit the form$/ do
	click_button('Create Submission')
end


Then /^I should see errors$/ do
	page.should have_content("Some errors were found, please take a look:")
end

Then /^I should see successfully$/ do
	page.should have_content("successfully")
end

When /^I destroy submission (\d+)$/ do |id|
  click_link "destroy_#{id}"
end

When /^I cancel submission (\d+)$/ do |id|
  click_link "cancel_#{id}"
end

Given /^I select a single file$/ do
  attach_file('submission_file', "features/uploads/valid_submission.txt")
end

Given /^I select a zip file$/ do
  attach_file('submission_file', "features/uploads/valid_submissions.zip")
end

Given /^I select an empty zip file$/ do
  attach_file('submission_file', "features/uploads/empty_submissions.zip")
end

Given /^I select an invalid zip file$/ do
  attach_file('submission_file', "features/uploads/invalid_submissions.zip")
end

Given /^I fill in invalid submission$/ do
	@submission = FactoryGirl.build(:submission)
	fill_in('submission_title',:with => @submission.title)
	fill_in('submission_peak_cutoff',:with => @submission.peak_cutoff)
	fill_in('submission_precursor_mass_tolerance',:with => @submission.precursor_mass_tolerance)
	fill_in('submission_product_mass_tolerance',:with => @submission.product_mass_tolerance)
	fill_in('submission_fract_prod_peaks',:with => @submission.fract_prod_peaks)
	click_button('Create Submission')
	page.should_not have_content("successfully")
end


Then /^(\w+) should be on page$/ do |status|
	page.should have_content(status)
end

When /^Submission (\d+) has a results file$/ do |id|
  sub = Submission.find(id)
  sub.results_file = File.new("features/results/valid_result.omx", 'r')
  sub.save
end


Before('@background-jobs') do
  system "/usr/bin/env RAILS_ENV=cucumber rake jobs:work &"
  Delayed::Worker.delay_jobs = false
end

After('@background-jobs') do
  system "ps -ef | grep 'rake jobs:work' | grep -v grep | awk '{print $2}' | xargs kill -9"
  Delayed::Worker.delay_jobs = true
end

Given /^I select CSV as Output File$/ do
	select("CSV - Spread sheet", :from => "Output File")
end





#
#When /^jobs are run$/ do
#  Delayed::Job.work_off
#end
