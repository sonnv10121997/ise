$(document).on(`turbolinks:load`, function () {
  var currentUserId = $(`#current_user_id`).val();
  $(`#notifications_count`).html(recount_noti());

  App.message = App.cable.subscriptions.create({
    channel: `NotificationChannel`, current_user_id: currentUserId}, {
    connected: function () { },
    received: function (data) {
      if (data.notification) {
        var notification = data.notification;

        $(`#notifications_list`).prepend(notification.html);
        noty(notification.text, notification.noty_type);
      }
    }
  });
});
