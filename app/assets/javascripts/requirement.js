$(document).on(`turbolinks:load`, function () {
  var eventId = $(`#event_id`).val();
  var participantId = $(`#participant_id`).val();

  App.message = App.cable.subscriptions.create({
    channel: `RequirementChannel`,
    event_id: eventId}, {
    connected: function () { },
    received: function (data) {
      if (data.requirement) {
        var requirement = data.requirement;
        var isParticipant = (participantId == requirement.user_id);

        if (data.method == `check_requirement` && isParticipant) {
          $(`#requirement_${requirement.id}`).find(`#status`)
            .replaceWith(requirement.status);
        } else if (data.method == `upload_image` && isParticipant) {
          $(`#requirement_${requirement.id}`).find(`#images`)
            .html(requirement.image);
        }
      }
    }
  });

  $(`.extend_requirement`).on(`click`, function() {
    $(this).siblings(`#images, #requirement_options`).toggle();
  });
});
