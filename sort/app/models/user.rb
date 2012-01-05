class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable
  after_create :send_email_to_admin

  # Setup accessible (or protected) attributes for your model
  attr_accessible :name, :username, :email, :password, :password_confirmation, :approved, :enabled, :admin, :remember_me
  
  validates_presence_of :name, :username, :email
  validates_uniqueness_of :username, :email, :case_sensitive => false
  
  has_many :databases
  has_many :submissions
  
  def active_for_authentication? 
    super && approved? && enabled?
  end 

  #send email to admin after a user register in site
  def send_email_to_admin
    if self.approved == false and not User.get_admins.empty?
      UserMailer.new_user_registered self
    end
  end

  def send_approved_email
    UserMailer.user_account_confirmed self
  end

  # send the new user created by the admin an email with login details
  def send_user_details password
    UserMailer.new_user_details self, password
  end 

    
  def inactive_message 
    if !approved? 
      :not_approved 
    elsif !enabled?
      :not_enabled
    else 
      super # Use whatever other message 
    end 
  end
  
  def self.get_admins
    User.where("admin =?" , true)
  end

  def self.current
    Thread.current[:user]
  end
  
  def self.current=(user)
    Thread.current[:user] = user
  end


end
