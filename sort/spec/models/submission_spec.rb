require 'spec_helper'

describe Submission do
	
  subject { 
    file = fixture_file_upload(Rails.root.join("features/uploads/valid_submission.txt"), 'text/plain')
    FactoryGirl.create :submission, :file => file
  }
  
  it { should have_many(:fixed_protein_mods).through(:fixed_submission_protein_mods) }
  it { should have_many(:variable_protein_mods).through(:variable_submission_protein_mods) }
  it { should belong_to :ion_1}
  it { should belong_to :ion_2}
  it { should belong_to :user}
  
  # database association validation
  it { should belong_to :database_version}
  
  
  it { should belong_to :precursor_mass_search_t }
  it { should belong_to :product_mass_search_t }
  
  it { should validate_numericality_of :precursor_mass_tolerance }
  it { should validate_numericality_of :product_mass_tolerance }
  it { should validate_numericality_of :fract_prod_peaks }
  it { should validate_numericality_of :peak_cutoff }
 

  it "should return the user if the user exists" do
    subject.user = FactoryGirl.build :user, :name => 'Mark'
    subject.get_user.should == 'Mark'
  end

  it "should return N/A if the user does not exist" do
    subject.user = nil
    subject.get_user.should == 'N/A'
  end

  context "user_can_delete should" do
    before :each do
      @user1 = FactoryGirl.create :user #, :approved => true, :enabled => true
      @user2 = FactoryGirl.create :user #, :approved => true, :enabled => true
      @admin1 = FactoryGirl.create :user, :admin => true #, :approved => true, :enabled => true
      subject.user = @user1
    end
    it "return true for the current user" do
      #@user1 = FactoryGirl.build :user #, :approved => true, :enabled => true
      #puts @user1

      subject.user_can_delete(@user1).should == true
    end
    it "return false for a different user" do
      #@user1 = FactoryGirl.create :user, :approved => true, :enabled => true
      #puts subject.user.id, @user1.id
      subject.user_can_delete(@user2).should == false 
    end
    it "returns true for an admin user" do
      subject.user_can_delete(@admin1).should == true
    end

    it "returns true for an nil user" do
      subject.user = nil
      subject.user_can_delete(@user1).should == true
    end
  end

  it "should not accept no file upload" do
    submission = FactoryGirl.build :submission
    submission.should_not be_valid
  end
  
  it "should only allow numeric values for text entry fields" do
    #TODO Can be removed when we are sure validates numericality works
    file = fixture_file_upload(Rails.root.join("features/uploads/valid_submission.txt"), 'text/plain')
    
    s = FactoryGirl.build :submission, :file => file
    s.should be_valid
    s.precursor_mass_tolerance = "Hello World"
    s.should_not be_valid
    
    
    s2 = FactoryGirl.build :submission, :file => file
    s2.should be_valid
    s2.product_mass_tolerance = "Hello World"
    s2.should_not be_valid
  end
  
  it "should upload a valid txt file" do
    should be_valid
  end
  
  it "should not upload an invalid file, such as a png" do
		subject.file = fixture_file_upload(Rails.root.join("features/uploads/invalid_submission.png"), 'image/png')
    should_not be_valid
  end
    
  it "should be in progress when no other jobs in progress" do
		subject.save()
    subject.status.should == "w"
  end
  
  it "should remain waiting in the queue if another job is in progress" do
    file = fixture_file_upload(Rails.root.join("features/uploads/valid_submission.txt"), 'text/plain')
    submission = FactoryGirl.create :submission, :file => file
    submission.status.should == "w"
    submission2 = FactoryGirl.create :submission, :file => file
    submission2.status.should == "w"
  end
  
  it "should change the statues from p to c when the job is completed" do
    subject.complete_job("c")
    subject.status.should == "c"
  end
  
  it "should change the statues from p to f when the job fail to complete" do
    subject.complete_job("f")
    subject.status.should == "f"
  end

  it "should change the statues from p to s when the job is skipped or cancelled" do
    subject.complete_job("s")
    subject.status.should == "s"
  end

  it "should display in progress when the submission status is p " do
		subject.status = "p"
  	subject.get_status().should == "In progress"
  	subject.get_status_css().should == "info"
  end
  
  it "should display waiting when the submission status is w " do
   subject.status = "w"
   subject.get_status().should == "Waiting"	
 	subject.get_status_css().should == "warning"
  end
  
  it "should display waiting when the submission status is w " do
   subject.status = "f"
   subject.get_status().should == "Failed"	
 	subject.get_status_css().should == "error"
  end
  
  it "should display waiting when the submission status is w " do
   subject.status = "c"
   subject.get_status().should == "Completed"	
 	 subject.get_status_css().should == "success"
  end

  it "should display cancelled when the submission status is s " do
   subject.status = "s"
   subject.get_status().should == "Cancelled" 
   subject.get_status_css().should == "warning"
  end

	it "Should show the exception message if an error is called" do
    subject.error('job', 'Exception was called')
    subject.status.should == 'f';
    subject.error_message.should == 'Exception was called'
  end

  it "Should show the exception message if an failure is called" do
    subject.failure()
    subject.status.should == 'f';
  end
	
	describe "should display the correct items in each list" do
		
		before(:each) do
			file = fixture_file_upload(Rails.root.join("features/uploads/valid_submission.txt"), 'text/plain')
	    @sub_1 = FactoryGirl.create :submission, :title => 'Sub 1', :file => file, :status => 'p', :updated_at => '2011-11-22 21:28:31 UTC', :created_at => '2011-11-22 21:28:31 UTC'
	    @sub_2 = FactoryGirl.create :submission, :title => 'Sub 2', :file => file, :status => 'w', :updated_at => '2011-11-25 21:28:31 UTC', :created_at => '2011-11-25 21:28:31 UTC'
	    @sub_3 = FactoryGirl.create :submission, :title => 'Sub 3', :file => file, :status => 'w', :updated_at => '2011-11-24 21:28:31 UTC', :created_at => '2011-11-24 21:28:31 UTC'
	    @sub_4 = FactoryGirl.create :submission, :title => 'Sub 4', :file => file, :result => "features/uploads/valid_result.omx", :status => 'c', :updated_at => '2011-11-23 21:28:31 UTC', :created_at => '2011-11-23 21:28:31 UTC'
	    @sub_5 = FactoryGirl.create :submission, :title => 'Sub 5', :file => file, :result => "features/uploads/invalid_result.omx",  :status => 'f', :updated_at => '2011-11-29 21:28:31 UTC', :created_at => '2011-11-29 21:28:31 UTC'
      @sub_6 = FactoryGirl.create :submission, :title => 'Sub 6', :file => file, :status => 's', :updated_at => '2011-11-20 21:28:31 UTC', :created_at => '2011-11-20 21:28:31 UTC'
     # @sub_1.email = true
	  end
	
		it "should display the results file, if it exists" do
			@sub_1.result.should == ''
			@sub_4.result.should == "features/uploads/valid_result.omx"
		end
	
		it "should display all P and W in the queue" do
			list = Submission.queue_list()
		  list.length().should == 3
			
	    list[0].title.should ==  'Sub 1'
	    list[1].title.should ==  'Sub 3'
		  list[2].title.should ==  'Sub 2'
		end
		
		it "should display all C, F and S in the results" do
			list = Submission.result_list()
			list.length().should == 3

	    list[0].title.should ==  'Sub 5'
	    list[1].title.should ==  'Sub 4'
      list[2].title.should ==  'Sub 6'
		end
		
		it "should display the in progress submission" do
			Submission.get_in_progress().title.should == 'Sub 1'
		end
		
		it "should have no jobs to complete once a job is completed and send email" do

      @sub_1.email = true 
      @sub_1.send_mail("message").should be_true
		end

    it "should have no jobs to complete once a job is completed without sending a email" do
      @sub_1.email = false
      @sub_1.send_mail("message").should_not be_true
    end
	end

  it "should have correct commandline argument for factory submission" do
    #libfile = File.open(Rails.root.join("features/sequence_library/valid_database10.fasta"))
   
    file = File.open(Rails.root.join("features/sequence_library/valid_database2.fasta"))
    d = FactoryGirl.build :database_version, :file => file

    subject.database_version = d
    expectedOutput = "./omssacl -w -to 5.2 -te 2.3 -e 1 -zl 2 -zh 5 -zt 6 -v 8 -hl 4 -he 11.0 -tez 1 -zcc 2 -cp 0 -mf 0,0 -mv 0,0 -mm 1 -tom 0 -tem 0 -i 0,2 -d '#{Rails.root.join("public#{d.file}").to_s}' '#{Rails.root.join("public/files/submission/#{subject.id}/file/valid_submission.txt")}' -ox '#{Rails.root.join("public/files/submission/#{subject.id}/")}valid_submission.omx'"


		subject.make_commandline.should == expectedOutput
  end

it "should have correct commandline argument for factory submission" do
    #libfile = File.open(Rails.root.join("features/sequence_library/valid_database10.fasta"))
   
    file = File.open(Rails.root.join("features/sequence_library/valid_database2.fasta"))
    d = FactoryGirl.build :database_version, :file => file

    subject.database_version = d
    subject.output_filetype = "2"
    expectedOutput = "./omssacl -w -to 5.2 -te 2.3 -e 1 -zl 2 -zh 5 -zt 6 -v 8 -hl 4 -he 11.0 -tez 1 -zcc 2 -cp 0 -mf 0,0 -mv 0,0 -mm 1 -tom 0 -tem 0 -i 0,2 -d '#{Rails.root.join("public#{d.file}").to_s}' '#{Rails.root.join("public/files/submission/#{subject.id}/file/valid_submission.txt")}' -oc '#{Rails.root.join("public/files/submission/#{subject.id}/")}valid_submission.csv'"


		subject.make_commandline.should == expectedOutput
  end
  
  it "should have correct commandline argument for Robin's SearchGUI Test" do

    rT = Submission.new()
    rT.max_missed_cleavages = 2
    rT.hitlist_max_length = 25
    rT.e_value_cutoff = 100
    #max_var_mods
    rT.precursor_mass_tolerance = 10
    rT.product_mass_tolerance = 0.5

    rT.l_bound_precursor = 2
    rT.u_bound_precursor = 4

    rT.min_charge = 3
    Enzyme.create(:name => "Hi Enzyme", :external_id => 1)
    rT.enzyme = Enzyme.find(1)

    Ion.create(:name => "Ion1", :external_id => 1)
    Ion.create(:name => "Ion2")
    Ion.create(:name => "Ion3")
    Ion.create(:name => "Ion4", :external_id => 4)
    rT.ion_1 = Ion.find(1)
    rT.ion_2 = Ion.find(4)

    #rT.precursor_mass_scale = true
    #rT.estimate_precursor_charge = true
    #rT.fract_prod_peaks = 0
    #rT.peak_cutoff = 0
    #rT.ints_peaks = 0
    #f = fixture_file_upload(Rails.root.join("features/uploads/0414Apr2011 BSA QC.mgf"), 'text/plain')
    f = File.open(Rails.root.join("features/uploads/0414Apr2011 BSA QC.mgf"))
    rT.file = f

    file = fixture_file_upload(Rails.root.join("features/sequence_library/valid_database2.fasta"), 'text/plain')
    d = FactoryGirl.build :database_version, :file => file
    rT.database_version = d

    if not rT.valid?
      puts "rT is invalid: Here are the errors"
      puts rT.errors.full_messages
    end
    rT.should be_valid
    #puts rT.errors[:name]
    #rT.product_mass_search_type << MassSearchType.create(:name => "SearchType1")
    rT.save!


    #TODO Change infile + outfile to full path
    expectedOut = "./omssacl -w -to 0.5 -te 10.0 -e 1 -zl 2 -zh 4 -v 2 -he 100.0 -tez 1 -zcc 2 -cp 0 -mm 64 -tom 0 -tem 0 -i 1,4 -d '#{Rails.root.join("public#{d.file}").to_s}' -fm '#{Rails.root.join("public/files/submission/#{rT.id}/file/0414Apr2011_BSA_QC.mgf")}' -ox '#{Rails.root.join("public/files/submission/#{rT.id}/")}0414Apr2011_BSA_QC.omx'"
    rT.make_commandline.should == expectedOut


    #rT.make_commandline.should == "omssacl -w -to 0.5 -te 10.0 -e 0 -zl 2 -zh 4 -v 2 -he 100.0 -tez 1 -zcc 2 -cp 0 -tom 0 -tem 0 -i 1,4 -d uniprot_sprot.fasta -fm '/home/robin/Desktop/SearchGUI-1.6.2_mac_and_linux/MyFiles/0414Apr2011 BSA QC.mgf' -ox /home/robin/Desktop/SearchGUI-1.6.2_mac_and_linux/OutputFiles/0414Apr2011 BSA QC.omx"
  end

  it "creates a new database" do
    file = fixture_file_upload(Rails.root.join("features/sequence_library/valid_database2.fasta"), 'text/plain')
    d = FactoryGirl.build :database_version, :file => file
    file = fixture_file_upload(Rails.root.join("features/uploads/valid_submission.txt"), 'text/plain')
    
    s = FactoryGirl.build :submission, :file => file

    s.database_version = d
    s.should be_valid
  end

  it "should run the perform method on a valid submission" do
    subject.precursor_mass_tolerance = 2
    subject.status.should == 'w'
    subject.perform
    subject.status.should == 'c'
  end

  it "should run the perform method on a valid submission" do
    subject.precursor_mass_tolerance = 6
    subject.status.should == 'w'
    subject.perform
    subject.status.should == 'f'
  end

  #context "extract_file_extension should return correct file extension" do
  #  it "when extension is .txt" do
  #    Submission.extract_file_extension("this file.txt").should == 'txt'
  #  end
  #
  #  it "when extension is .mgf" do
  #    Submission.extract_file_extension("MGFFile.mgf").should == "mgf"
  #  end
  #
  #  it "when there is no extension" do
  #    Submission.extract_file_extension("noExtFile").should == ""
  #  end
  #
  #  it "when there are multiple dots" do
  #    Submission.extract_file_extension("This.Is/A long path/.with.mgf").should == "mgf"
  #  end
  #end
  

  context "on the results page, when i limit by:" do
    before (:each) do
      f = fixture_file_upload(Rails.root.join("features/uploads/valid_submission.txt"), 'text/plain')
      currentCreated = Time.now
      lastDayCreated = Time.now.ago(17*60*60)
      lastWeekCreated = Time.now.ago(6*24*60*60)
      lastCreated = Time.now.ago(39*24*60*60)
      #Own, 24hrs, Complete
      FactoryGirl.create(:submission, :file => f, :updated_at => lastDayCreated, :status => 'c', :user_id => 1)
      #Own, lastWeek, Complete
      FactoryGirl.create(:submission, :file => f, :updated_at => lastWeekCreated, :status => 'c', :user_id => 1)
      #Own, lastYear, Complete
      FactoryGirl.create(:submission, :file => f, :updated_at => lastCreated, :status => 'c', :user_id => 1)


      #other, 24hrs, Complete
      FactoryGirl.create(:submission, :file => f, :updated_at => lastDayCreated, :status => 'c', :user_id => 2)
      #other, lastWeek, Complete
      FactoryGirl.create(:submission, :file => f, :updated_at => lastWeekCreated, :status => 'c', :user_id => 2)
      #other, lastYear, Complete
      FactoryGirl.create(:submission, :file => f, :updated_at => lastCreated, :status => 'c', :user_id => 2)


      #own, 24hrs, Failed 
      FactoryGirl.create(:submission, :file => f, :updated_at => lastDayCreated, :status => 'f', :user_id => 1)
      #other, lastWeek, Failed 
      FactoryGirl.create(:submission, :file => f, :updated_at => lastWeekCreated, :status => 'f', :user_id => 2)
    end
    #after(:all) do
    #  Submission.all.each do |s| s.destroy() end
    #end
    it "results all" do
      list = Submission.result_list()
      #list.each do |l| puts l.title end
      list.length().should == 8
    end

    context "results in last day" do
      it "get all in the last day" do
        list = Submission.result_filter(:time => :last_day)
        list.length().should == 3
      end
      it "also restricts by own searches" do
        list = Submission.result_filter(:time => :last_day, :user => 1)
        list.length().should == 2
      end
      it "also restricts by failure" do
        list = Submission.result_filter(:time => :last_day, :status => ['f'])
        list.length.should == 1
      end
      it "also restricts by own searches and also restricts by complete" do
        list = Submission.result_filter(:time => :last_day, :user => 1, :status => ['c'])
        list.length.should == 1
      end
    end

    context "results in last week" do
      it "get all in the last week" do
        list = Submission.result_filter(:time => :last_week)
        list.length().should == 6
      end
      it "also restricts by own searches" do
        list = Submission.result_filter(:time => :last_week, :user => 1)
        list.length().should == 3
      end
    end

    context "results in last month" do
      it "get all in the last month" do
        list = Submission.result_filter(:time => :last_month)
        list.length().should == 6
      end
    end
    context "results in last year" do
      it "get all in the last year" do
        list = Submission.result_filter(:time => :last_year)
        list.length().should == 8
      end
    end

    context "results of all time" do
      it "gets all results" do
        list = Submission.result_filter()
        list.length.should == 8
      end
      it "also restricts by own searches" do
        list = Submission.result_filter(:user => 1)
        list.length().should == 4
      end
      it "also restricts by own searches and also restricts by complete" do
        list = Submission.result_filter(:user => 1, :status => ['c'])
        list.length.should == 3
      end
    end

  end
end
#end

