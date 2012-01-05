class DatabasesController < ApplicationController
  # modules
  include FileManager

  # Devise authencation
  #before_filter :authenticate_user!
  #assigning the current user_id
  before_filter :set_current_user

  # GET /databases
  # GET /databases.json
  def index
    # displaying databases, for an admin => show all 
    # for any other user => show their own databases
    if ! current_user.admin?
        @databases = Database.where("user_id= ? and enabled=? ", User.current, true)
    else
       @databases = Database.all
    end 
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @databases }
    end
  end

  # GET /databases/1
  # GET /databases/1.json
  def show

    @database = Database.find(params[:id])
    
    if ! current_user.admin
        @database_versions = DatabaseVersion.where("enabled=? and database_id=?", true, params[:id]) 
    else 
        @database_versions = DatabaseVersion.where("database_id=?",params[:id]) 
    end
     
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @database }
    end
  end
    
  # GET /databases/new
  # GET /databases/new.json
  def new
    @database = Database.new

    
    respond_to do |format|
      if low_space?
        flash[:warning] = "Low disk space!"
      end
      format.html # new.html.erb
      format.json { render json: @database }
    end
  end

  # GET /databases/1/edit
  def edit
    @database = Database.find(params[:id])
  end

  # POST /databases
  # POST /databases.json
  def create
    @database = Database.new
    @database.title = params[:database][:title]
    @database.user_id = User.current.id
    theFile =  params[:database][:file]
    @database_version = DatabaseVersion.new(:file => params[:database][:file])
   
    if (theFile!=nil)
      @database_version.database_title = theFile.original_filename
      @database.database_versions << @database_version
    end 
    
    respond_to do |format|
      if ! @database_version.nil? and @database_version.valid? and @database.valid?
        @database.save 
        @database_version.save
        Delayed::Job.enqueue @database_version
        #@database_version.perform

        format.html { redirect_to @database, notice: 'Database was successfully created.' }
        format.json { render json: @database, status: :created, location: @database }
      else
        format.html { redirect_to @database, notice: 'Database was not successfully created.'} 
        format.json { render json: @database.errors, status: :unprocessable_entity }
      end
    end
  end


  # PUT /databases/1
  # PUT /databases/1.json
  def update
    # updating a database - just add another file to an existing database
    @database = Database.find(params[:id])
    @database.title = params[:database][:title]
    theFile =  params[:database][:file]
   
    if (theFile!=nil)
      @database_version = DatabaseVersion.new(:file => params[:database][:file])
      @database_version.database_title = theFile.original_filename
      puts @database_version.database_title
      @database.database_versions << @database_version
    end

    respond_to do |format|
     if ! @database_version.nil? and @database_version.save and @database.save
        Delayed::Job.enqueue @database_version
        #@database_version.perform
        format.html { redirect_to @database, notice: 'Database was successfully updated'}
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @database.errors, status: :unprocessable_entity }
      end
    end
  end

  def show_versions
    
    @database = Database.find(params[:id])
    @database_versions = DatabaseVersion.processed.where("database_id = ? and enabled=? ", params[:id],true)
  
    respond_to do |format|  
      format.html { render json: @database_versions }
      format.json { render json: @database_versions }
    end
  end
 
  def show_version
    
    @database_version = DatabaseVersion.find(params[:id])
  
    respond_to do |format|  
      format.html 
      format.json { render json: @database_version }
    end
  end 

  # disabling a whole database -- childern should be disabled too
  def disableall
    @database = Database.find(params[:id])
    
    respond_to do |format|
      if @database.update_attribute(:enabled, false)
        format.html { redirect_to databases_path , :flash => { :notice => 'Database sucessfully Disabled' } }
        format.json { head :ok }
      end 
    end
  end
  
  def enableall
    @database = Database.find(params[:id])
    
    respond_to do |format|
      if @database.update_attribute(:enabled, true)
        format.html { redirect_to databases_path , :flash => { :notice => 'Database was sucessfully enabled' } }
        format.json { head :ok }
      end 
    end
  end
  
  # destroying a database and all of its childern => remove the files from the system
  def destroyall
    @database = Database.find(params[:id])
    @database_version = DatabaseVersion.where("database_id= ?", params[:id])
    FileUtils.rm_rf "public/sequence_library/#{params[:id]}"
   
    @database_version.each do |d|
      d.destroy 
    end
    @database.destroy

    respond_to do |format|
      format.html { redirect_to databases_url }
      format.json { head :ok }
    end
  end
  
  
  # GET /databases/1/editDatabaseName
   def editDatabaseName
     @database = Database.find(params[:id]) 
   end


   # PUT /databases/1
   # PUT /databases/1.json
   def updateDatabaseName
     # updating a database - just add another file to an existing database
     @database = Database.find(params[:id]) 
     @database.update_attribute(:title, params[:database][:title]) 
   
     respond_to do |format|
        if @database.save!
            format.html { redirect_to databases_url, notice: 'Database name was successfully updated'}
            format.json { head :ok }
        end
     end
   end
  
end
