$(document).on(`turbolinks:load`, function () {
  var eventId = $(`#event_id`).val();
  var currentUserId = $(`#current_user_id`).val();

  App.message = App.cable.subscriptions.create({
    channel: `RequirementChannel`,
    event_id: eventId}, {
    connected: function () { },
    received: function (data) {
      var requirement = data.requirement;
      var reqUserIsCurrentUser = (currentUserId == requirement.user_id);

      if (data.method == `check_requirement` && reqUserIsCurrentUser) {
        $(`#requirement_${requirement.id}`).find(`#status`)
          .replaceWith(requirement.status);
      } else if (data.method == `upload_image` && !reqUserIsCurrentUser) {
        $(`#requirement_${requirement.id}`).find(`#images`)
          .append(requirement.image);
      }
    }
  });
});
