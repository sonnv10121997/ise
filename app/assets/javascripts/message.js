$(document).on(`turbolinks:load`, function () {
  var conversationId = $(`#messages`).data(`conversation-id`);
  var currentUserId = $(`#current_user_id`).val();

  $(`.message_detail`).each(function() {
    checkDeleteable(this);
  });

  App.message = App.cable.subscriptions.create({
    channel: `MessageChannel`, conversation_id: conversationId}, {
    connected: function () { },
    received: function (data) {
      if (data.message !== undefined) {
        var message = data.message;
        var messUserIsCurrentUser = (currentUserId == message.user_id);

        if (data.method === `create` && !messUserIsCurrentUser) {
          $(`#messages`).append(message.html);
          checkDeleteable(`.message_detail:last`);
        } else if (data.method === `destroy` && !messUserIsCurrentUser) {
          $(`#message_${message.id}`).remove();
        }
      }
    }
  });
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
