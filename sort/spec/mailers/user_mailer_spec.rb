require "spec_helper"

describe UserMailer do
  before(:each) do
    file = fixture_file_upload(Rails.root.join("features/uploads/valid_submission.txt"), 'text/plain')
    @submission = FactoryGirl.create :submission, :file => file
    @submission.user =  FactoryGirl.create :user
    @submission.user.email =  "omssaweb@gmail.com"
    @omssa_message = "ok" 
    @admin1 = FactoryGirl.create :admin ,:email => "admin@example.com"
    @admin2 = FactoryGirl.create :admin
    @user1 = FactoryGirl.create :user, :email => "user@example.com"
    @user1.approved = false
    @user2 = FactoryGirl.create :user
    @user2.approved = true
    ActionMailer::Base.deliveries =[]
  end
  
  it "should send email on successful job completion" do

    @submission.user.should_not be_nil
    UserMailer.job_complete(@submission , @omssa_message).deliver

    ActionMailer::Base.deliveries.should_not be_empty
    mail = ActionMailer::Base.deliveries.last

    'omssaweb@gmail.com'.should == mail['from'].to_s
    @submission.user.email.should == mail['to'].to_s
    mail.body.to_s.include?(@submission.user.name).should be_true
    mail.body.to_s.include?(@submission.id.to_s).should be_true
    mail.body.to_s.include?(@submission.title).should be_true
    mail.body.to_s.include?("http").should be_true
  end
  
  it "should send an email for new user to admin testing header" do

    @user1.approved.should == false
    @user1.send_email_to_admin

    admin_emails = []
    User.get_admins.each do |admin|
      admin_emails << admin.email
    end 
    @list_of_admins= admin_emails.join(", ")
    
    #ActionMailer::Base.deliveries.should_not be_empty
    ActionMailer::Base.deliveries.length.should ==1
    mail = ActionMailer::Base.deliveries.last

    'omssaweb@gmail.com'.should == mail['from'].to_s
    @list_of_admins.should == mail['to'].to_s
    
    #mail.body.to_s.include?(@submission.user.name).should be_true
    #mail.body.to_s.include?(@submission.id.to_s).should be_true
    #mail.body.to_s.include?(@submission.title).should be_true
    #mail.body.to_s.include?("http").should be_true
  end

  # testing for a new user whose approved --> admin should not get an email
  it "should not send an email to admin if the new user is already approved" do
    @user2.approved.should == true
    @user2.send_email_to_admin  
    ActionMailer::Base.deliveries.should be_empty
  end
  
  it "should send an email for new user to admin testing body" do
    @user1.approved.should == false
    @user1.send_email_to_admin
    
    ActionMailer::Base.deliveries.should_not be_empty
    #puts ActionMailer::Base.deliveries
    ActionMailer::Base.deliveries.each do |m|
      m.body
    end
    mail = ActionMailer::Base.deliveries.first

    #mail.body.to_s.include?(@user1.name).should be_true
    mail.body.to_s.include?("http").should be_true
    
 
  end
  
  it "should send an email to new user after admin approved the recent user's account" do
    @user1.approved.should == false
    @user1.send_approved_email
    ActionMailer::Base.deliveries.should_not be_empty
    mail = ActionMailer::Base.deliveries.last
    ActionMailer::Base.deliveries.length.should ==1    
  end
  
  it "should send an email to new user after admin approved the recent user's account testing body" do

    @user1.send_approved_email
    ActionMailer::Base.deliveries.should_not be_empty
    mail = ActionMailer::Base.deliveries.last
    #ActionMailer::Base.deliveries.length.should ==1   
    'omssaweb@gmail.com'.should == mail['from'].to_s
    @user1.email.should == mail['to'].to_s
    mail.body.to_s.include?(@user1.name).should be_true
    #mail.body.to_s.include?(@submission.id.to_s).should be_true
    #mail.body.to_s.include?(@submission.title).should be_true
    mail.body.to_s.include?("http").should be_true 
  end

  it "should send an email once a db version has been converted using db blast where the user is an admin" do
     submitted_database = FactoryGirl.create :database, :title => "db_1", :user => @user1
     db_version = fixture_file_upload(Rails.root.join("features/sequence_library/valid_database.fasta"), 'text/plain')
     submitted_version= FactoryGirl.create :database_version, :database => submitted_database, :file => db_version
     User.current = @admin1
     #User.current.email = @admin1.email
     submitted_version.email_isSent
     ActionMailer::Base.deliveries.should_not be_empty
     mail = ActionMailer::Base.deliveries.last
  end 

  it "should send an email once a db version has been converted using db blast where the user is the database owner" do
     submitted_database = FactoryGirl.create :database, :title => "db_1", :user => @user1
     db_version = fixture_file_upload(Rails.root.join("features/sequence_library/valid_database.fasta"), 'text/plain')
     submitted_version= FactoryGirl.create :database_version, :database => submitted_database, :file => db_version
     User.current = @user1

     submitted_version.email_isSent
     ActionMailer::Base.deliveries.should_not be_empty
     mail = ActionMailer::Base.deliveries.last
  end 
end
