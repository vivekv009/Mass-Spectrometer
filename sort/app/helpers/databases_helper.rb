module DatabasesHelper
  def database_state_to_css database_version
    if database_version.error_message.nil?
      if database_version.processed
        return "success" 
      else
        return "info processing" 
      end
    else
      return "error"
    end
  end 

  def database_alert_message database_version
    database_state = database_state_to_css database_version


    html = ""
      html << "<p class='alert-message #{database_state}'>"
      html << database_state.gsub("info ", "").capitalize
    html << "</p>"
    html.html_safe



  end

  #def display_edit(database)
    #if database.user_id == User.current.id 
   #   link_to 'Edit', edit_database_path(database)
    #end
  #end
=begin   
  def disable_database_path(database)
    if database.enabled == true
       link_to 'Disable Database', databases_disableall_path
    else 
       link_to 'Enable Database', databases_enableall_path
    end 
  end 
  
  def destroyall_database_path(database) 
    if database.enabled == false 
      link_to 'Delete Database', databases_destroyall_path
    end 
  end
=end  

#def display_destroy(database)
 # if database.user_id == User.current.id 
  #  link_to 'disableall', database
    #link_to 'Destroy', database, :confirm => 'Are you sure?', :method => :delete
  #end
#end
end
