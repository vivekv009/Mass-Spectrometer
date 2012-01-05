class Database < ActiveRecord::Base
  
  # validations for the uploaded database
  validates :title, :presence => true
  validates_uniqueness_of :title, :on => :create
  #attr_accessor :file
  #validates :file, :presence => true
  
 
  # association between databaseVersions and databases
  has_many :database_versions 
  
  # association between a database and a user (a user can add many databases)
  belongs_to :user, :class_name => 'User', :foreign_key => "user_id"
  
end
