$(document).on(`turbolinks:load`, function () {
  var eventId = $(`#event_id`).val();
  var currentUserId = $(`#current_user_id`).val();

  App.message = App.cable.subscriptions.create({
    channel: `ParticipantChannel`, event_id: eventId}, {
    connected: function () { },
    received: function (data) {
      if (data.user_id !== undefined) {
        var participantIsCurrentUser = (currentUserId == data.user_id);
      }

      if (data.enroll_request !== undefined && data.event_participants !== undefined) {
        var enroll_request = data.enroll_request;
        var event_participants = data.event_participants;

        if (data.method == `update` && participantIsCurrentUser) {
          $(`#enroll_request`).replaceWith(enroll_request.html);
          $(`#event_participants`).html(event_participants.html);
        }
      }

      if (data.method == `delete` && participantIsCurrentUser) {
        Swal.fire({
          title: I18n.t(`swal.error.removed_from_course`),
          type: `error`, showCancelButton: false,
          confirmButtonText: I18n.t(`swal.ok`),
          confirmButtonColor: confirmButtonColor,
          cancelButtonColor: cancelButtonColor
        }).then(function() {
          location.href = data.url;
        });
      }
    }
  });

  $(document).on(`click`, `.add_participants`, function() {
    Swal.fire({
      title: I18n.t(`swal.warning.add_participant`),
      text: I18n.t(`swal.warning.cannot_be_undo`),
      type: `warning`, showCancelButton: true,
      confirmButtonText: I18n.t(`swal.confirm`),
      cancelButtonText: I18n.t(`swal.cancel`),
      confirmButtonColor: confirmButtonColor,
      cancelButtonColor: cancelButtonColor
    }).then((result) => {
      if (result.value) {
        var event_slug = $(`#event_slug`).attr(`value`);
        var status = $(this).siblings(`#user_enroll_event_status`).attr(`value`);
        var user_slug = $(this).siblings(`#user_slug`).attr(`value`);

        $.ajax({
          url: `/user_enroll_events/${event_slug}`,
          type: `PATCH`,
          data: {
            'user_enroll_event[status]': status,
            'user_slug': user_slug
          },
          success: function() {
            Swal.fire({
              title: I18n.t(`swal.success.add_participant`),
              type: `success`, showCancelButton: false,
              confirmButtonText: I18n.t(`swal.ok`),
              confirmButtonColor: confirmButtonColor,
              cancelButtonColor: cancelButtonColor
            });
          }
        });
      }
    });
  });

  $(document).on(`click`, `.remove_participants`, function() {
    Swal.fire({
      title: I18n.t(`swal.warning.remove_participant`),
      text: I18n.t(`swal.warning.cannot_be_undo`),
      type: `warning`, showCancelButton: true,
      confirmButtonText: I18n.t(`swal.confirm`),
      cancelButtonText: I18n.t(`swal.cancel`),
      confirmButtonColor: confirmButtonColor,
      cancelButtonColor: cancelButtonColor
    }).then((result) => {
      if (result.value) {
        var event_slug = $(`#event_slug`).attr(`value`);
        var status = $(this).siblings(`#user_enroll_event_status`).attr(`value`);
        var user_slug = $(this).siblings(`#user_slug`).attr(`value`);

        $.ajax({
          url: `/user_enroll_events/${event_slug}`,
          type: `DELETE`,
          data: {
            'user_enroll_event[status]': status,
            'user_slug': user_slug
          },
          success: function() {
            Swal.fire({
              title: I18n.t(`swal.success.remove_participant`),
              type: `success`, showCancelButton: false,
              confirmButtonText: I18n.t(`swal.ok`),
              confirmButtonColor: confirmButtonColor,
              cancelButtonColor: cancelButtonColor
            }).then(function() {
              location.href = `/user_enroll_events/${event_slug}`;
            });
          }
        });
      }
    });
  });
});
