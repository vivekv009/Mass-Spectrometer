require 'open3'

class Submission < ActiveRecord::Base


  attr_accessor :database
  # attr_accessor :email
  #TODO See if the client wants these fields
  attr_accessor :precursor_mass_scale, :estimate_precursor_charge, :eliminate_precursor
  #These are used by SearchGui, But the client has not suggested they are
  #desired. Hence they (And the corresponding code in make_commandline) have
  #been commented out
  #def precursor_mass_scale 
  #  true
  #end
  #def estimate_precursor_charge 
  #  true
  #end
  #def eliminate_precursor 
  #  false 
  #end

  # after_save :add_to_queue
  # before_save :check_queue
  
  has_many :fixed_submission_protein_mods, :class_name  => "SubmissionProteinMod", :conditions => {"submission_protein_mods.category" => "fixed"}
  has_many :fixed_protein_mods, :through => :fixed_submission_protein_mods, :source => :protein_mod
  has_many :variable_submission_protein_mods, :class_name  => "SubmissionProteinMod", :conditions => {"submission_protein_mods.category" => "variable"}
  has_many :variable_protein_mods, :through => :variable_submission_protein_mods, :source => :protein_mod
  

  belongs_to :user
  
  belongs_to :ion_1, :class_name => 'Ion', :foreign_key => "ion_1_id"
  belongs_to :ion_2, :class_name => 'Ion', :foreign_key => "ion_2_id"
  belongs_to :enzyme, :class_name => 'Enzyme', :foreign_key => "enzyme_id"
  
  belongs_to :precursor_mass_search_t, :class_name => 'MassSearchType', :foreign_key => "precursor_mass_search_type"
  belongs_to :product_mass_search_t, :class_name => 'MassSearchType', :foreign_key => "product_mass_search_type"

  belongs_to :database_version

  validates :file, :presence => true

  #validates :results_file

  validates :database_version, :presence => true
  
  validates :precursor_mass_tolerance, :numericality => true, :allow_nil => true
  validates :product_mass_tolerance, :numericality => true, :allow_nil => true
  validates :fract_prod_peaks, :numericality => true, :allow_nil => true
  validates :peak_cutoff, :numericality => true, :allow_nil => true
  
  mount_uploader :file, SubmissionFileUploader
  mount_uploader :results_file, SubmissionResultsFile

  IN_PROGRESS = "p"
  FAILED = "f"
  COMPLETED = "c"
  WAITING = "w"
  CANCELLED = "s" # or known as Skipped

  def get_status()
    if self.status == IN_PROGRESS
      "In progress"
    elsif self.status == FAILED
      "Failed"
    elsif self.status == COMPLETED
      "Completed"
    elsif self.status == CANCELLED
      "Cancelled"
    else 
      "Waiting"
    end
  end

  def get_status_css()
    if self.status == IN_PROGRESS
      "info"
    elsif self.status == FAILED
      "error"
    elsif self.status == COMPLETED
      "success"
    elsif self.status == CANCELLED
      "warning"
    else 
      "warning"
    end
  end

  def complete_job(status)
		self.status = status
		self.save!
  end

  def self.get_in_progress
		Submission.where("submissions.status = '#{IN_PROGRESS}'").limit(1).first
	end

  def self.queue_list
    Submission.order('created_at ASC').where("submissions.status = '#{IN_PROGRESS}' OR submissions.status = '#{WAITING}'")
  end

	def self.result_list
    Submission.order('updated_at DESC').where("submissions.status = '#{COMPLETED}' OR submissions.status = '#{FAILED}' OR submissions.status = '#{CANCELLED}'")
  end

  def make_commandline
    if Rails.env.production?
      #output = ["/usr/local/bin/omssacl -w"] 
      output = ["./omssacl -w"] 
    else
      output = ["./omssacl -w"] 
    end

    if product_mass_tolerance != 2.0 &&  product_mass_tolerance != 1.0
      output.push("-to")
      output.push(product_mass_tolerance.to_s)
    end
    if precursor_mass_tolerance != 2.0 &&  precursor_mass_tolerance != 1.0
      output.push("-te")
      output.push(precursor_mass_tolerance.to_s)
    end
   
    if enzyme
      output.push("-e")
      output.push(enzyme.external_id)
    end    

    if l_bound_precursor && l_bound_precursor !=1 &&  l_bound_precursor !=-1
      output.push("-zl")
      output.push(l_bound_precursor)
    end
    
    if u_bound_precursor && u_bound_precursor !=1 &&  u_bound_precursor !=-1
      output.push("-zh")
      output.push(u_bound_precursor)
    end
    
    if min_charge && min_charge !=3 && min_charge !=-1
      output.push("-zt")
      output.push(min_charge)
    end
    
    if max_missed_cleavages !=1 && max_missed_cleavages !=-1
      output.push("-v")
      output.push(max_missed_cleavages)
    end
    
    if hitlist_max_length !=25 && hitlist_max_length !=-1
      output.push("-hl")
      output.push(hitlist_max_length)
    end
    
    if e_value_cutoff !=1 && e_value_cutoff !=-1
      output.push("-he")
      output.push(e_value_cutoff.to_f.to_s)
    end
    
    output.push("-tez")
    #if precursor_mass_scale
      output.push("1")
    #else
    #  output.push("0")
    #end

    output.push("-zcc")
    #if estimate_precursor_charge
      output.push("2")
    #else
    #  output.push("1")
    #end

    output.push("-cp")
    #if eliminate_precursor 
    #  output.push("1")
    #else
      output.push("0")
    #end
     
    if fixed_protein_mods.count > 0
      output.push("-mf")
      output.push((fixed_protein_mods.map do |fm| fm.external_id end).join(","))
    end
    if variable_protein_mods.count > 0
      output.push("-mv")
      output.push((variable_protein_mods.map do |fm| fm.external_id end).join(","))
   end

    if max_var_mods
      output.push("-mm")
      output.push(max_var_mods)
    end

   output.push("-tom")
   output.push("0")
   output.push("-tem")
   output.push("0")

   if ion_1 != nil && ion_2 !=nil
     output.push("-i")
     #output.push(ion_1.name+ "," +ion_2.name)
     output.push(ion_1.external_id.to_s+ "," +ion_2.external_id.to_s)
   end

   #TODO Load submission's selected database once the database select box is
   #added from adding_database_new
   output.push("-d")
   filePath =  self.database_version.file.to_s #.split('.')[0..-2].join(".")
   output.push("'"+Rails.root.join("public#{filePath}").to_s+"'")

   #@file_extension = nil 
   if file and file.path
     if (file.path.end_with?(".mgf"))
       output.push("-fm")
     #elsif (Submission.extract_file_extension(file.path) == "pkl")
     #  output.push("-fp")
     #elsif (Submission.extract_file_extension(file.path) == "dta")
     #  output.push("-f")
     end
     output.push("'#{self.file.path}'")
     if  output_filetype == "1"
         @file_extension = ".omx" 
     output.push("-ox '#{self.output_path}'")
     elsif  output_filetype == "2"
          @file_extension = ".csv"
     output.push("-oc '#{self.output_path}'") 
     end
    end
    output.join(" ")
  end

  def output_path
      @file_extension = ".omx" 
  if  output_filetype == "2"
      @file_extension = ".csv"
     end 
     "#{Rails.root.join("public/files/submission/#{id}/")}"+self.file.to_s.split('/')[-1].split('.')[0..-2].join(".")+ @file_extension
  end

  #def self.extract_file_extension(fname)
  #  if (not fname.nil?) and fname.include? "."
  #    fname.split('.')[-1]
  #  else
  #    ""
  #  end
  #end


  def get_user
    if self.user != nil
      user.name
    else
      "N/A"
    end
  end

  def user_can_delete(current_user)
    if self.user.nil?
      true
    else
      (self.user.id == current_user.id) or (current_user.admin?)
    end
  end



  def perform
    self.status = IN_PROGRESS
    self.save!


    # runCmd = "/Users/markdessain/Documents/Genesys_Projects/2011-psm/omssaintergrating/app/tools/OMSSA/omssa-2.1.9.macos/omssacl"
    runCmd = self.make_commandline()
    #puts runCmd

    stdin, stdout, stderr = Open3.popen3(runCmd)
    errors = stderr.readlines

    puts errors
    if errors.length == 0
      self.results_file = File.new(self.output_path)
      self.complete_job(COMPLETED)
      
      self.delay.send_mail(stdout.readlines.join("\n"))
    else
      # puts errors
      self.error_message = errors.join("\n")
      self.complete_job(FAILED)
      self.delay.send_mail(self.error_message)
    end


  end

  def send_mail(message)
    if self.email == true
      UserMailer.job_complete(self, message)

    end
  end

  def success(job)
    # self.status = COMPLETED
    # self.save!
  end

  def error(job, exception)
    self.error_message = exception
    self.status = FAILED
    self.save!
  end

  def failure
    self.status = FAILED
    self.save!  
  end



  def self.result_filter(queryDictionary={})
    #TODO Could pass in a correct dictionary, instead of modifying it here
    #puts queryDictionary
    case queryDictionary.fetch(:time, nil)
    #TODO Refactor this so that it adds directly to the hash
    when :last_day, 'last_day'
      queryTime = Time.now.ago(24*60*60)
    when :last_week, "last_week"
      queryTime = Time.now.ago(7*24*60*60)
    when :last_month, 'last_month'
      queryTime = Time.now.ago(30*24*60*60)
    when :last_year, 'last_year'
      queryTime = Time.now.ago(365*24*60*60)
    else
      queryTime = Time.new(0)
    end
    
    whereHash = {"updated_at" => queryTime..Time.now}

    userQuery = queryDictionary.fetch(:user, "")
    if not userQuery.nil? and not userQuery == ""
        whereHash["user_id"] = userQuery
    end

    statusVal = queryDictionary.fetch(:status, "")
    if statusVal == ""
      statusVal = [COMPLETED, FAILED, CANCELLED]
    else
      statusVal = statusVal.split("")
    end

    whereHash["status"] = statusVal
    #puts whereHash
    Submission.order('updated_at DESC').where(whereHash)
  end

end



