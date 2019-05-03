$(document).on('turbolinks:load', function() {
  $(`.extend_course_info`).on(`click`, function() {
    $(`#course_info`).toggle();
  });
});
