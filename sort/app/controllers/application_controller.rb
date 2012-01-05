class ApplicationController < ActionController::Base
  protect_from_forgery
  # use user_layout before each init
  before_filter :user_layout
  private
  
  # Check if user is signed in
  def user_layout
    if user_signed_in?
      # If user is admin, set admin flag
      if current_user.admin?
        @admin = true
      end
      # set users fullname for display
      @user_name = current_user.name
      @user = current_user
    end
    
  end
  
  def set_current_user
      User.current = current_user
  end
  
end
