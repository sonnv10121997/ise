$(document).on('turbolinks:load', function() {
  $('.content').scroll(function() {
    if ($('.content').scrollTop() >= 138) {
      $('#user_event_tabs').addClass('fixed_header');
    } else {
      $('#user_event_tabs').removeClass('fixed_header');
    }
  });
});
