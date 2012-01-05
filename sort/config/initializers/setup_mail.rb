#setup mail server here!
#for time being we create a username = omssaweb with password = omssaweb in gmail
#omssaweb@gmail.com

ActionMailer::Base.smtp_settings = {
  :address              => "smtp.gmail.com",
  :port                 => 587,
  :domain               => "velocity.com",
  :user_name            => "omssaweb",
  :password             => "omssaweb",
  :authentication       => "plain",
  :enable_starttls_auto => true
}
