$(document).on('turbolinks:load', function() {
  $('#sidebarCollapse').on('click', function () {
    console.log(`#sidebarCollapse click function`);
    $('#sidebar').toggleClass('active');
    $('.content').toggleClass('active');
  });

  $('#preloader').delay(500).fadeOut();
});
