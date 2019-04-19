$(document).on(`turbolinks:load`, function () {
  var senderId = $(`#messages`).data(`sender-id`);

  $(`.message_detail`).each(function() {
    checkDeleteable(this);
  });

  App.message = App.cable.subscriptions.create(`MessageChannel`, {
    connected: function () {
      var conversationId = $(`#messages`).data(`conversation-id`);

      this.perform(`listen_create_message`, {conversation_id: conversationId});
      this.perform(`listen_destroy_message`, {conversation_id: conversationId});
    },
    received: function (data) {
      if (data.method === `create`) {
        $(`#messages`).append(data.message);
        checkDeleteable(`.message_detail:last`);
        $(`#message_content`).val(``);
      } else if (data.method === `destroy`) {
        $(`#message_${data.message.id}`).remove();
      }
    }
  });

  function checkDeleteable(element) {
    if ($(element).data(`message-user-id`) === senderId) {
      $(element).find(`.destroy_message`).css(`display`, `inherit`);
    }
  }
});
