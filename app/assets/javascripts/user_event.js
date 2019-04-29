$(document).on('turbolinks:load', function() {
  $('.content').scroll(function() {
    if ($('.content').scrollTop() >= 138) {
      $('#user_event_tabs').addClass('fixed_header');
    } else {
      $('#user_event_tabs').removeClass('fixed_header');
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
