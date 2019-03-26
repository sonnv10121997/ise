$(document).on(`turbolinks:load`, function() {
  $(`.tab`).on(`click`, function() {
    $(`.tab`).removeClass(`button button-text`).addClass(`btn button-text-default`);
    $(this).removeClass(`btn button-text-default`).addClass(`button button-text`);
    var clickedIndex = $(`.tab`).index(this);

    var panels = $(`.tab_panel`);
    panels.removeClass(`active`);
    $(panels[clickedIndex]).addClass(`active`);
  });

  $(document).on(`click`, `#enroll_button`, function() {
    swal(I18n.t(`swal.warning.send_enrolling_request`),
      I18n.t(`swal.warning.wait_to_be_approved`), `warning`, true,
      I18n.t(`swal.confirm`), I18n.t(`swal.cancel`)
    ).then((result) => {
      if (result.value) {
        var event_id = $(`#event_id`).attr(`value`);

        $.ajax({
          url: `/user_enroll_events`,
          type: `POST`,
          data: { 'event_id': event_id },
          success: function() {
            swal(I18n.t(`swal.success.send_enrolling_request`),
              I18n.t(`swal.success.wait_to_be_approved`), `success`, false,
              I18n.t(`swal.ok`)
            )
          }
        });
      }
    });
  });

  $(document).on(`click`, `#unenroll_button`, function() {
    swal(I18n.t(`swal.warning.stop_sending_enroll_request`), ``, `warning`, true,
      I18n.t(`swal.confirm`), I18n.t(`swal.cancel`)
    ).then((result) => {
      if (result.value) {
        var event_id = $(`#event_id`).attr(`value`)

        $.ajax({
          url: `/user_enroll_events/${event_id}`,
          type: `DELETE`,
          success: function() {
            swal(I18n.t(`swal.success.stop_sending_enroll_request`), ``,
              `success`, false, I18n.t(`swal.ok`)
            )
          }
        });
      }
    });
  });
});
