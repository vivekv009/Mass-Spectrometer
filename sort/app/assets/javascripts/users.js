$(document).ready(function () {
  // tabify all tabs
  $(".tabs").tabs();
  
    // init modal window
  $('#add_user_modal').modal({
    backdrop: true,
    keyboard: false
  });
  
  // bind add database button
  $('#add_user_button').on('click', function() {
    $('#add_user_modal').modal('show');
  });
  
  // bind cancel button of modal
  $('.closemodal').on('click', function() {
    modal_id = $(this).parent().parent().attr('id');
    $('#'+modal_id).modal('hide');
  });
});
