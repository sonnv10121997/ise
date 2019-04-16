$(document).on(`turbolinks:load`, function () {
  App.message = App.cable.subscriptions.create(`MessageChannel`, {
    connected: function () {
      var conversationId = $(`#messages`).data(`conversation-id`);
      this.perform(`listen_new_message`, {conversation_id: conversationId});
    },
    received: function (data) {
      var message = JSON.parse(data.message);
      var senderId = $(`#messages`).data(`sender-id`);
      if (message.user_id !== senderId) {
        this.updateMessage(message);
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
