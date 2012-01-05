// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.


$(document).ready(function () {
  
  //$("#submission_database li:first-child").trigger('click');

  
   
  $('#new_submission #submission_database_version_id option').remove();		
 	$("#new_submission #submission_database").change(function (e) {

 		$.get('/databases/' + this.value + '/versions' , function(data) {

 			versions = jQuery.parseJSON(data);

			$('#new_submission #submission_database_version_id option').remove();
			$('#new_submission #submission_database_version_id').append($("<option></option>").attr("value","").text("select a database version")); 

			jQuery.each(versions, function(index, itemData) {
		  		new_version = "Added: " + itemData.created_at; // can be itemData.database_title; instead
		  		$('#new_submission #submission_database_version_id').append($("<option></option>").attr("value",itemData.id).text(new_version)); 
			});
		});
	});

var current_database_version = null;

var highlighted_list = [];
$('#submission_database li a').click(function(s){

  // reset highlight
  for(i in highlighted_list) {
    $(highlighted_list[i]).removeClass("highlighted");
  }
  highlighted_list = [];

  // Defaults
  var type = $(this).parent().parent().attr("class"); 
  var id = 0;
  var version = null;


  // Type of press
  if (type == "database_id") {
    version = $("li:first",$(this).siblings("ul.database_versions"));
    current_database_version = $(version).children()[1];
    id = $(version).attr("id");
  } else if (type == "database_versions") {
    current_database_version = this;
    id = $(current_database_version).parent().attr("id");
  }

  if(current_database_version != null) {

    var parent_element = current_database_version;

    // Loop though until parent is reached
    do {
      highlighted_list.push(parent_element);
      $(parent_element).addClass("highlighted");
      var temp = $(parent_element).parent().parent().parent();
      var parent_element = $(temp).children()[1];
      var parent_id = $(temp).attr("id");
    } while (parent_id != "submission_database");

    // Set the hidden field
    if (id != null)
    {
      $('#submission_database_version').val(id);
    }
  }

  
   // Toggle click
  $("#submission_database").jstree("toggle_node", this);
  
  return false;
  

});


 
jQuery("#submission_database").jstree({ "themes" : {"theme" : "classic" },"plugins" : [ "themes", "html_data","themeroller", "ui", ] });      

 
});





