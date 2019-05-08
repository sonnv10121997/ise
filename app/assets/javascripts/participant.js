$(document).on(`turbolinks:load`, function () {
  var eventId = $(`#event_id`).val();
  var currentUserId = $(`#current_user_id`).val();
  var leaderId = $(`#leader_id`).val();

  if (eventId) {
    App.message = App.cable.subscriptions.create({
      channel: `ParticipantChannel`, event_id: eventId}, {
      connected: function () { },
      received: function (data) {
        if (data.method == `create` && data.participant) {
          $(`#participants`).append(data.participant.html);
          checkParticipantEnrollable(`.participant_detail:last`);
        }

        if (data.user_id) {
          var currentUserIsPariticipant = (currentUserId == data.user_id);
        }

        if (data.enroll_request && data.event_participants) {
          var enroll_request = data.enroll_request;
          var event_participants = data.event_participants;

          if (data.method == `update`) {
            if (currentUserIsPariticipant) {
              $(`#enroll_request`).replaceWith(enroll_request.html);
              $(`#event_participants`).html(event_participants.html);
            } else {
              $(`#participant_${data.user_id}`).replaceWith(data.participant.html);
              $(`#participant_${data.user_id} ~ hr:first`).remove();
              checkParticipantEnrollable(`#participant_${data.user_id} .participant_detail`);
            }
          }
        }

        if (data.method == `delete_from_leader` && currentUserIsPariticipant) {
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

        if (data.method == `delete_from_student` && currentUserId == leaderId && data.event_participants) {
          $(`#participant_${data.user_id}, #participant_${data.user_id} ~ hr `)
            .remove();
          $(`#event_participants`).html(data.event_participants.html);
        }
      }
    });
  }

  $(document).on(`click`, `.add_participants`, function() {
    Swal.fire({
      title: I18n.t(`swal.warning.add_participant`),
      type: `warning`, showCancelButton: true,
      confirmButtonText: I18n.t(`swal.confirm`),
      cancelButtonText: I18n.t(`swal.cancel`),
      confirmButtonColor: confirmButtonColor,
      cancelButtonColor: cancelButtonColor
    }).then((result) => {
      if (result.value) {
        var event_slug = $(`#event_slug`).attr(`value`);
        var status = $(this).siblings(`#user_enroll_event_status`).attr(`value`);
        var user_id = $(this).siblings(`#user_id`).attr(`value`);

        $.ajax({
          url: `/user_enroll_events/${event_slug}`,
          type: `PATCH`,
          data: {
            'user_enroll_event[status]': status,
            'user_id': user_id
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

  $(document).on(`click`, `.unenroll_participants`, function() {
    Swal.fire({
      title: I18n.t(`swal.warning.unenroll_participant`),
      type: `warning`, showCancelButton: true,
      confirmButtonText: I18n.t(`swal.confirm`),
      cancelButtonText: I18n.t(`swal.cancel`),
      confirmButtonColor: confirmButtonColor,
      cancelButtonColor: cancelButtonColor
    }).then((result) => {
      if (result.value) {
        var event_slug = $(`#event_slug`).attr(`value`);
        var status = $(this).siblings(`#user_enroll_event_status`).attr(`value`);
        var user_id = $(this).siblings(`#user_id`).attr(`value`);

        $.ajax({
          url: `/user_enroll_events/${event_slug}`,
          type: `PATCH`,
          data: {
            'user_enroll_event[status]': status,
            'user_id': user_id
          },
          success: function() {
            Swal.fire({
              title: I18n.t(`swal.success.unenroll_participant`),
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
        var user_id = $(this).siblings(`#user_id`).attr(`value`);

        $.ajax({
          url: `/user_enroll_events/${event_slug}`,
          type: `DELETE`,
          data: {
            'user_id': user_id
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

  $(`.participant_detail`).each(function() {
    checkParticipantEnrollable(this);
  });

  $(document).on(`click`, `.participant`, function() {
    $(`.participant`).removeClass(`active`);
    $(this).addClass(`active`);
  });
});

function checkParticipantEnrollable(element) {
  var leaderId = $(`#leader_id`).val();

  if ($(`#current_user_id`).val() != leaderId) {
    $(element).hide();
  }
}
