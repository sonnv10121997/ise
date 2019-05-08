$(document).on(`turbolinks:load`, function () {
  var eventId = $(`#event_id`).val();
  var currentUserId = $(`#current_user_id`).val();

  if (eventId) {
    App.message = App.cable.subscriptions.create({
      channel: `RequirementChannel`,
      event_id: eventId}, {
      connected: function () { },
      received: function (data) {
        if (data.requirement) {
          var requirement = data.requirement;
          var reqUserIsCurrentUser = (currentUserId == requirement.user_id);

          if (data.method == `check_requirement` && reqUserIsCurrentUser) {
            $(`#requirement_${requirement.id}`).find(`#status`)
              .replaceWith(requirement.status);
          } else if (data.method == `upload_image` && !reqUserIsCurrentUser) {
            $(`#requirement_${requirement.id}`).find(`#images`)
              .html(requirement.image);
          }
        }
      }
    });
  }

  $(`.extend_requirement`).on(`click`, function() {
    $(this).siblings(`#images, #requirement_options`).toggle();
  });

  $(document).on(`click`, `#images .req_img img`, function() {
    Swal.fire({
      imageUrl: $(this).prop(`src`),
      width: 960
    });
  });
});
