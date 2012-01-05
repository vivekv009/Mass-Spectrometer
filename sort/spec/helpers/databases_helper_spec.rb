require 'spec_helper'

# Specs in this file have access to a helper object that includes
# the DatabasesHelper. For example:
#
# describe DatabasesHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       helper.concat_strings("this","that").should == "this that"
#     end
#   end
# end
describe DatabasesHelper do
  #pending "add some examples to (or delete) #{__FILE__}"
=begin  
  subject {
    file = fixture_file_upload(Rails.root.join("features/sequence_library/valid_database.fasta"), 'text/fasta')
    FactoryGirl.create :database, :user_id => 10, :file => file
  }
  
  it "should allow a user to update their own databases" do
    User.current = 10 
    subject.user_id.should = 10
    #display_edit(subject).should == link_to ('Edit', edit_database_path(subject))
    #display_edit(subject).should == link_to 'Destroy', database, :confirm => 'Are you sure?', :method => :delete
  end     
  #end
  
=end

  context "database_state_to_css" do
    it "should give no extra css if DV is successfully processed" do
      @dv = DatabaseVersion.new :processed => true, :error_message => nil
      helper.database_state_to_css(@dv).should match ""
    end
    it "should give processing css if DV is not processed" do
      @dv = DatabaseVersion.new :processed => false, :error_message => nil
      helper.database_state_to_css(@dv).should match "processing"
    end
    it "should give error css if there is an error message" do
      @dv = DatabaseVersion.new :processed => true, :error_message => "THIS IS YOUR ERROR MESSAGE" 
      helper.database_state_to_css(@dv).should match "error"
    end
    it "should only give error css if DV is unprocessed and there is an error" do
      @dv = DatabaseVersion.new :processed => false, :error_message => "THIS IS YOUR ERROR MESSAGE" 
      helper.database_state_to_css(@dv).should match "error"
    end
  end
  context "database_alert_message" do

    it "should show a info message for a database which is been processed" do
      @dv = DatabaseVersion.new :processed => false
      helper.database_alert_message(@dv).should match "<p class='alert-message info processing'>Processing</p>" 
    end
    it "should show a success message for a database which has been processed" do
      @dv = DatabaseVersion.new :processed => true
      helper.database_alert_message(@dv).should match "<p class='alert-message success'>Success</p>" 
    end
    it "should show a error message for a database which has been processed with an error" do
      @dv = DatabaseVersion.new :processed => false, :error_message => "Error Message"
      helper.database_alert_message(@dv).should match "<p class='alert-message error'>Error</p>" 
    end


  end
end 
