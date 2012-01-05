$(document).ready(function () {
  
  var $area = "#user_guide #managingDatabases ";

  // Main
  scrollToPoint($area + ".point-1", "#database-upload", 1000);
  scrollToPoint($area + ".point-2", "#database-versions", 1000);
  scrollToPoint($area + ".point-3", "#database-update", 1000);
  scrollToPoint($area + ".point-4", "#database-edit", 1000);
  scrollToPoint($area + ".point-14", "#database-admin", 1000);

  // Upload
  scrollToPoint($area + ".point-7", "#database-view", 1000);

  // Versions
  scrollToPoint($area + ".point-15", "#database-disable-versions", 1000);

  // Update
  scrollToPoint($area + ".point-11", "#database-view", 1000);

  // Edit
  scrollToPoint($area + ".point-13", "#database-view", 1000);

  // Admin
  // scrollToPoint($area + ".point-1", "#database-upload", 1000);

});

function scrollToPoint(start, end, speed) {
  $(start).click(function() {
    
    $('html,body').animate({
      scrollTop: $(end).offset().top - 110
    }, speed);
    return false;
  });
}
