require 'spec_helper'

describe DatabaseVersion do
  
  it { should belong_to :database}  

  # Test1
  it "should not accept no file upload" do
    submitted_database = FactoryGirl.build :database_version, :file => " "
    submitted_database.should_not be_valid
  end

  #Test2
  it "should upload a valid fasta file" do
    file = fixture_file_upload(Rails.root.join("features/sequence_library/valid_database10.fasta"), 'text/plain')
    submitted_database = FactoryGirl.build :database_version, :file => file
    submitted_database.should be_valid
  end

  #Test3     
  it "should not upload an invalid file, such as a png" do
    invalid_file = fixture_file_upload(Rails.root.join("features/sequence_library/invalid_database.png"), 'image/png')
    submitted_database = FactoryGirl.build :database_version, :file => invalid_file
    submitted_database.should_not be_valid
  end 

  #Test4
  context "This valid example" do
    subject {
      user1 = FactoryGirl.create :user
      User.current = user1
      submitted_database = FactoryGirl.create :database, :title => "db_1", :user => user1
      file = File.new(Rails.root.join("features/sequence_library/valid_database.fasta"))
      submitted_version = FactoryGirl.create :database_version, :file => file, :database => submitted_database
    }

    it "should have correct commandline argument for creating decoy database" do
      expected_output = "./makeblastdb -in #{Rails.root.join("public/sequence_library/#{subject.id}/valid_database.fasta")}"
      subject.make_blastdb.should == expected_output
    end

    it "should run the perform method" do
      subject.processed.should == false
      subject.perform
      subject.processed.should == true
    end
  end

  #Test5
  context "This invalid example" do
    subject {
      #user1 = FactoryGirl.create :user
      #submitted_database = FactoryGirl.create :database, :title => "db_1", :user => user1
      file = File.new(Rails.root.join("features/sequence_library/valid_database.fasta"))
      submitted_version = FactoryGirl.create :database_version, :file => file

    }

    it "should run the perform method" do
      subject.stub(:make_blastdb).and_return("./makeblastdb -ex")
      subject.processed.should == false
      subject.perform
      subject.processed.should == false
      subject.error_message.should_not == nil
    end 
  end

  it "to_str should run for a factory build" do
    file = fixture_file_upload(Rails.root.join("features/sequence_library/valid_database10.fasta"), 'text/plain')
    submitted_version = FactoryGirl.build :database_version, :file => file
    submitted_version.should be_valid
    submitted_version.to_s.should be_an_instance_of(String)
  end
  

  it "should destroy a signle version " do 

    submitted_database= FactoryGirl.create :database, :title => "db1", :id => "1"
    file = fixture_file_upload(Rails.root.join("features/sequence_library/valid_database.fasta"))
    file2 = fixture_file_upload(Rails.root.join("features/sequence_library/valid_database.fasta"))

    submitted_version = FactoryGirl.create :database_version, :file => file, :database => submitted_database, :created_at => "2012-03-10 18:31:00"
    submitted_version2 = FactoryGirl.create :database_version, :file => file2, :database => submitted_database, :created_at => "2012-03-10 18:31:10"
    FileUtils.rm(file).should be_true 
  end 


  it "allow automaic database destraction" do

      submitted_database= FactoryGirl.create :database, :title => "db1", :id => "1", :enabled => false
      file = File.open(Rails.root.join("public/sequence_library/#{submitted_database.id}/valid_database.fasta"))
      directory = Rails.root.join("public/sequence_library/#{submitted_database.id}")
      submitted_version = FactoryGirl.create :database_version, :file => file, :database => submitted_database, :enabled => false
    
      File.delete(file).should be_true
      submitted_version.delete_db.should eql([submitted_database.destroy])
      FileUtils.rm_rf(directory).should be_true

  end
end
