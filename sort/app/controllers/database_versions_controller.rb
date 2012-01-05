class DatabaseVersionsController < ApplicationController
  # Devise authencation
  #before_filter :authenticate_user!

  # disabling a database version
  def disable
    @database_version = DatabaseVersion.find(params[:id])
    @database_version.update_attribute(:enabled, false)
    @database_version.disable_db

    respond_to do |format|
      if Database.where("id=? and enabled=?",@database_version.database_id, true) == []
        #TODO --> if disable_db then confirem and redirect_to databases_url, notice: "Database was disabled"
        flash[:success] = "Database is successfully disabled"
        format.html { redirect_to databases_url}
        format.json { head :ok }  
      else
        flash[:success] = "Database version is successfully disabled"
        format.html { redirect_to :action => "show", :controller => "databases", :id => @database_version.database_id }
        format.json { head :ok }
      end 
    end
  end

  # enabling a database version 
  def enable
    @database_version = DatabaseVersion.find(params[:id])
    @database_version.update_attribute(:enabled, true) 
    enable_status_1 = Database.find(@database_version.database_id).enabled
    @database_version.enable_db
    enable_status_2= Database.find(@database_version.database_id).enabled
    

    respond_to do |format|
      if (enable_status_1 != enable_status_2)
        flash[:success] = "Database is successfully enabled"
        format.html { redirect_to databases_url}
        format.json { head :ok } 
      else 
        flash[:success] = "Database version is successfully enabled" 
        format.html { redirect_to :action => "show", :controller => "databases", :id => @database_version.database_id }
      end 
    end
  end
  
  # destroying a database version => remove the file from the system
  def destroy
    @database_version1 = DatabaseVersion.find(params[:id])
    @database_version = DatabaseVersion.where("database_id=?", @database_version1.database_id)

    # if the number of versions is more than 1 ==> just remove the file
    if @database_version.count > 1
      begin 
        File.delete("public/sequence_library/#{@database_version1.database_id}/#{@database_version1.database_title}")
        @database_version1.destroy
      rescue 

      end 

      #
    # if the versions number is 1 ==> remove the whole folder
    elsif @database_version.count == 1
      FileUtils.rm_rf 'public/sequence_library/#{@database_version1.database_id}'
      @database_version1.delete_db
    end 

    respond_to do |format|
      # if the whole database has been destroyed the redirect to databases page
      if Database.where("id=?",@database_version1.database_id).count ==0 
        flash[:success] = "Database is completely removed from the system"
        format.html { redirect_to databases_url}
        format.json { head :ok }    
      # redirect to the show method  
      else 
        flash[:success] = "Database version is destroyed"
        format.html { redirect_to :action => "show", :controller => "databases", :id => @database_version1.database_id}
        format.json { head :ok }
      end 
    end
  end
  
end
