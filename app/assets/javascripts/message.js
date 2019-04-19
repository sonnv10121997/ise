$(document).on(`turbolinks:load`, function () {
  App.message = App.cable.subscriptions.create(`MessageChannel`, {
    connected: function () {
      var conversationId = $(`#messages`).data(`conversation-id`);

      this.perform(`listen_create_message`, {conversation_id: conversationId});
      this.perform(`listen_destroy_message`, {conversation_id: conversationId});
    },
    received: function (data) {
      var message = data.message
      var senderId = $(`#messages`).data(`sender-id`);

      if (message.user_id !== senderId && message.method === `create`) {
        this.updateMessage(message);
      } else if (message.user_id !== senderId && message.method === `destroy`) {
        $(`#message_${message.id}`).remove();
      }
    },
    updateMessage: function(message) {
      $.ajax({
        url: `/conversations/update`,
        type: `PATCH`,
        data: { 'message': message }
      });
    }
  });
});
