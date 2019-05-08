$(document).on(`turbolinks:load`, function() {
  $(`.tab`).on(`click`, function() {
    $(`.tab`).removeClass(`button button-text`).addClass(`btn button-text-default`);
    $(this).removeClass(`btn button-text-default`).addClass(`button button-text`);
    var clickedIndex = $(`.tab`).index(this);

    var panels = $(`.tab_panel`);
    panels.removeClass(`active`);
    $(panels[clickedIndex]).addClass(`active`);
  });

  $(document).on(`click`, `#unenroll_button`, function() {
    Swal.fire({
      title: I18n.t(`swal.warning.send_enrolling_request`),
      text: I18n.t(`swal.warning.wait_to_be_approved`),
      type: `warning`, showCancelButton: true,
      confirmButtonText: I18n.t(`swal.confirm`),
      cancelButtonText: I18n.t(`swal.cancel`),
      confirmButtonColor: confirmButtonColor,
      cancelButtonColor: cancelButtonColor
    }).then((result) => {
      if (result.value) {
        var event_slug = $(`#event_slug`).attr(`value`);
        var user_id = $(`#user_id`).attr(`value`);

        $.ajax({
          url: `/user_enroll_events`,
          type: `POST`,
          data: {
            'event_id': event_slug,
            'user_id': user_id
          },
          success: function() {
            Swal.fire({
              title: I18n.t(`swal.success.send_enrolling_request`),
              text: I18n.t(`swal.success.wait_to_be_approved`),
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

  $(document).on(`click`, `#enrolling_button`, function() {
    Swal.fire({
      title: I18n.t(`swal.warning.stop_sending_enroll_request`),
      type: `warning`, showCancelButton: true,
      confirmButtonText: I18n.t(`swal.confirm`),
      cancelButtonText: I18n.t(`swal.cancel`),
      confirmButtonColor: confirmButtonColor,
      cancelButtonColor: cancelButtonColor
    }).then((result) => {
      if (result.value) {
        var event_slug = $(`#event_slug`).attr(`value`);
        var user_id = $(`#user_id`).attr(`value`);

        $.ajax({
          url: `/user_enroll_events/${event_slug}`,
          type: `DELETE`,
          data: { 'user_id': user_id },
          success: function() {
            Swal.fire({
              title: I18n.t(`swal.success.stop_sending_enroll_request`),
              type: `success`, showCancelButton: false,
              confirmButtonText: I18n.t(`swal.ok`),
              confirmButtonColor: confirmButtonColor,
              cancelButtonColor: cancelButtonColor
            }).then(function() {
              location.href = `/events/${event_slug}`;
            });
          }
        });
      }
    });
  });

  $(document).on(`click`, `#enrolled_button`, function() {
    Swal.fire({
      title: I18n.t(`swal.warning.send_unenroll_request`),
      text: I18n.t(`swal.warning.wait_to_be_approved`),
      type: `warning`, showCancelButton: true,
      confirmButtonText: I18n.t(`swal.confirm`),
      cancelButtonText: I18n.t(`swal.cancel`),
      confirmButtonColor: confirmButtonColor,
      cancelButtonColor: cancelButtonColor
    }).then((result) => {
      if (result.value) {
        var event_slug = $(`#event_slug`).attr(`value`);

        $.ajax({
          url: `/notifications`,
          type: `POST`,
          data: { 'event_id': event_slug },
          success: function() {
            Swal.fire({
              title: I18n.t(`swal.success.send_unenroll_request`),
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
});
