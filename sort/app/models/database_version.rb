class DatabaseVersion < ActiveRecord::Base
   validates :file, :presence => true

   belongs_to :database
   scope :processed, :conditions => ["processed = ?", true]
   #default_scope :processed => true
   
   # carrierwave 
   mount_uploader :file, DatabaseUploader
  
  def to_s
  	self.database.title + " version: " +  self.database.created_at.to_s# + " Database: "' + self.database_id.to_s + " ID: " + self.id.to_s
  end
  
  #disable a database when all of the versions are disabled 
  def disable_db
      Database.all.each do |d|
        if DatabaseVersion.where("database_id=? and enabled=?", d.id, true).count == 0
          d.update_attribute(:enabled, false)
        end 
      end
  end 
  
  #enable a database when all of the versions are disabled 
  def enable_db
      Database.all.each do |d|
        if DatabaseVersion.where("database_id=? and enabled=?", d.id, false).count == 0 and d.enabled == false
          d.update_attribute(:enabled, true)
        end 
      end
  end 

  #delete a database when all of the versions are deleted 
  def delete_db
      Database.all.each do |d|
        if DatabaseVersion.where("database_id=? and enabled=?", d.id, true).count == 0
          d.destroy 
        end 
      end
  end

  
  def perform
    
    runCmd = self.make_blastdb
    stdin, stdout, stderr = Open3.popen3(runCmd)
    errors = stderr.readlines

    if errors.length == 0
      #Success 
      #send an email to user
      #TODO : get user's email as a parameter
     
      self.delay.email_isSent
      self.processed = true
      self.save!
    else
      self.error_message = errors.join("\n")
      self.delay.email_failed
      self.save!
    end

  end

  def make_blastdb()
    if Rails.env.production?
      #output = ["/usr/bin/makeblastdb"]
      output = ["./makeblastdb"]
    else
      output = ["./makeblastdb"]
    end
    output.push("-in")
    output.push()
    output.push(Rails.root.join("public#{self.file.to_s}"))
    output.join(" ")
  end

  def email_isSent
     UserMailer.user_database_converted self
  end 

  def email_failed
     UserMailer.user_database_converted_failed(self, self.error_message)
     puts "Email sent"
  end 

end
