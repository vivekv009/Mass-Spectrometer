class UsersController < ApplicationController
  before_filter :authenticate_user!, :isAdmin, :setMarker
  
  # Set market to highlight top bar
  def setMarker
    # Set market for top bar
    @highlight_admin = true
  end
  
  # Check if user is an adimistrator
  def isAdmin
    if ! current_user.admin?
      redirect_to submission_queue_path, :flash => { :error => 'You do not have permission to access the admin area!' }
      # if user is not an admin redirect to home page and display message
    end
  end
  
  # build index page
  def index
    @users_admin = User.find_all_by_admin(true)
    @users_inactive = User.find_all_by_approved(false)
    @users_active = User.where(:admin => false, :approved => true, :enabled => true)
    @users_disabled = User.where(:enabled => false, :approved => true)
  end
  
  def show
    puts "Show"
  end

  # new user
  def new
    @highlight_new_user = true
    @user = User.new
    
    respond_to do |format|

      format.html 
      format.json { render json: @user}
    end
  end 

  # actuall creation of the new user 
  def create
    @user = User.new

    password = params[:user][:password]
    # enabling and approving the new user automatically
    params[:user][:enabled] = true
    params[:user][:approved] =true 
    
    respond_to do |format|
    if @user.update_attributes(params[:user])
        # send the user an email once created
        @user.send_user_details password
        format.html { redirect_to users_url , notice: 'User was successfully created' }
        format.json { head :ok }
    else
        format.html { render action: "new" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end
  
  # Approve a users account
  def approve
    @user = User.find(params[:user])
  
    respond_to do |format|
      if @user.update_attributes({:approved => true, :enabled => true})
        @user.send_approved_email

        format.html { redirect_to users_path , :flash => { :notice => 'User was successfully approved!' } }
        format.json { head :ok }
      else
        format.html { render action: "approved" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end
  
  # Enable a users account
  def enable
    @user = User.find(params[:user])
  
    respond_to do |format|
      if @user.update_attribute(:enabled, true)
        format.html { redirect_to users_path , :flash => { :notice => 'User sucessfully Enabled' } }
        format.json { head :ok }
      else
        format.html { render action: "approved" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end
  
  # disable a users account
  def disable
    @user = User.find(params[:user])
  
    respond_to do |format|
      if @user.update_attribute(:enabled, false)
        format.html { redirect_to users_path , :flash => { :notice => 'User sucessfully Disabled' } }
        format.json { head :ok }
      else
        format.html { render action: "approved" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end
  
  # Show users details on screen  
  def edit
    @user = User.find(params[:id])
  end


  # PUT /users/1
  # PUT /users/1.json
  def update
    @user = User.find(params[:id])
    
    # If password not specified edit other parameters
    if params[:user][:password].blank?
      params[:user].delete(:password)
      params[:user].delete(:password_confirmation)
    end
    
    # Admin account cannot be disabled
    if params[:user][:admin]
      params[:user][:enabled] = true
    end
    
    respond_to do |format|
      # admin should not be able to demote himself
      if current_user == @user and params[:user][:admin] == "0"
        format.html { redirect_to edit_user_path(@user) , notice: 'You cannot demote yourself!' }
        format.json { head :ok }
      elsif @user.update_attributes(params[:user])
        format.html { redirect_to edit_user_path(@user) , notice: 'User was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end
  
  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user = User.find(params[:id])
    
    respond_to do |format|
      if not @user.approved  and @user.destroy 
        format.html { redirect_to users_url, :flash => { :notice => 'User successfully deleted' } }
        format.json { head :ok }
      else
        format.html { redirect_to users_url, :flash => { :error => 'Cannot permanently remove user once approved! Please deactivate account' } }
        format.json { head :ok }
      end
    end
  end
  
end
