$(document).ready(function () {
  // init modal window
  $('#add_database_modal').modal({
    backdrop: true,
    keyboard: false
  });
  
  // bind add database button
  $('#add_database_button').on('click', function() {
    $('#add_database_modal').modal('show');
  });
  
  // bind cancel button of modal
  $('.closemodal').on('click', function() {
    modal_id = $(this).parent().parent().attr('id');
    $('#'+modal_id).modal('hide');
  });
});
