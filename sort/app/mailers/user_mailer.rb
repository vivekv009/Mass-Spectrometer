class UserMailer < ActionMailer::Base

 #by the help of this class we can send email to user
 #according to each function name such as "job_complete" there can be a file "j$
 #you can add your body to those corresponding file
 #for sending an email its enough to call the function from other controller
 #sample: UserMailer.job_complete("jon@doe.com" , "job completed").deliver
 layout 'user_mailer'
 default :from => "omssaweb@gmail.com"

 def job_complete(submission, message)
   @submission = submission
   @omssa_message = message
   mail(:to => submission.user.email , :subject => '[OMSSA] Job Finished').deliver  
 end

 def new_user_registered new_user
    #admins_name = [] 
    @last_user = new_user
    admins_emails = [] 
    User.get_admins.each do |admin| 
      admins_emails << admin.email
    end
    @ad_emails = User.get_admins.map(&:email)
    mail(:to => @ad_emails, :subject => '[OMSSA] New User Registered!').deliver
end
 
 #TODO : need to access user email directly
 def user_account_confirmed last_user
   @last_user = last_user
   mail(:to => @last_user.email , :subject => '[OMSSA] Your Account approved').deliver
 end

 
 #TODO : need to access user email directly
 def user_database_converted db_version 
   @user_email = db_version.database.user.email
   @database_version = db_version
   # @user_email = User.current.email
   mail(:to => @user_email, :subject => '[OMSSA] Your Fasta database has been converted').deliver
 end 

 def user_database_converted_failed(db_version, error_message)
   # @user_email = User.current.email
   @user_email = db_version.database.user.email
   @database_version = db_version
   @error_message = error_message
   mail(:to => @user_email, :subject => '[OMSSA] Your Fasta database failed').deliver
 end

def new_user_details last_user, password
   @last_user = last_user
   @password = password
   mail(:to => @last_user.email , :subject => '[OMSSA] Your Account approved').deliver
end 



end
