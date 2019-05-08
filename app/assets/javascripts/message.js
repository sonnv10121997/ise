$(document).on(`turbolinks:load`, function () {
  var currentUserId = $(`#current_user_id`).val();
  var eventId = $(`#event_id`).val();

  $(`.message_detail`).each(function() {
    checkDeleteable(this);
  });

  if (eventId) {
    App.message = App.cable.subscriptions.create({
      channel: `MessageChannel`, event_id: eventId}, {
      connected: function () { },
      received: function (data) {
        if (data.message && data.conversation_id) {
          var message = data.message;
          var messUserIsCurrentUser = (currentUserId == message.user_id);
          var conversationId = $(`#messages`).data(`conversation-id`);

          if (data.method === `create` && !messUserIsCurrentUser &&
            conversationId == data.conversation_id) {
            $(`#messages`).append(message.html);
            checkDeleteable(`.message_detail:last`);
            $(`#messages`).scrollTop($(`#messages`).prop(`scrollHeight`));
          } else if (data.method === `destroy` && !messUserIsCurrentUser) {
            $(`#message_${message.id}`).remove();
          }
        }
      }
    });
  }

  $(`#messages`).scrollTop($(`#messages`).prop(`scrollHeight`));
});

function checkDeleteable(element) {
  var senderId = $(`#messages`).data(`sender-id`);

  if ($(element).data(`message-user-id`) === senderId) {
    $(element).find(`.destroy_message`).css(`display`, `inherit`);
    $(element).find(`img.user_image_xx_small, .fa-user-circle, span.child`)
    .css(`display`, `none`);
    $(element).find(`h6.display_space_between, p`)
    .removeClass(`display_space_between`).addClass(`display_flex_end`);
  }
}
