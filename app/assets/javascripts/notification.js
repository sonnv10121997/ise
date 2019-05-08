$(document).ready(function () {
  var currentUserId = $(`#current_user_id`).val();

  if (currentUserId) {
    App.message = App.cable.subscriptions.create({
      channel: `NotificationChannel`, current_user_id: currentUserId}, {
      connected: function () { },
      received: function (data) {
        if (data.notification) {
          var notification = data.notification;

          $(`#notifications_detail`).prepend(notification.html);
          recount_noti();
          if (!((notification.type == 8 || notification.type == 9) &&
            notification.notifier_id == $(`.active > #participant_id`).val() &&
            $(`#messages`).length)) {
            noty(notification.text, notification.noty_type);
          }
        }
      }
    });
  }
});

$(document).on(`turbolinks:load`, function () {
  recount_noti();

  $(`#mark_all_as_read`).on(`click`, function() {
    $(`.not_read`).removeClass(`not_read`);
    recount_noti();
  });
});
