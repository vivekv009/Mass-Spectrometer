$(document).ready(function () {
  // Global Dropdown init
  $("body").click(function (e) {
	  $('.dropdown-toggle, .menu').parent("li").removeClass("open");
	});
	
	$(".dropdown-toggle, .menu").click(function (e) {
		var $li = $(this).parent("li").toggleClass('open');
		return false;
	});
  
  // Global popover init
  $("a[rel=popover]")
    .popover({
      offset: 0,
      placement: 'below'
    })
    .click(function(e) {
      e.preventDefault()
    });
  
});
