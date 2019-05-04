$(document).on('turbolinks:load', function() {
  $(`.extend_course_info`).on(`click`, function() {
    if ($(`#course_info`).css(`margin-top`) == "0px") {
      $(`#course_info`).css(`margin-top`, -$(`#course_info`).height());
    } else {
      $(`#course_info`).css(`margin-top`, 0);
    }
  });
});
