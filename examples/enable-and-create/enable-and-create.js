if (Meteor.isClient) {
  Template.notifications.allowsNotifications = function(){
    return window.webkitNotifications.checkPermission() == 0;
  }

  Template.notifications.events({
    'click .enable-notifications' : function () {
      window.webkitNotifications.requestPermission()
    },
    'click .create-notification' : function () {
      if(Meteor.userId()){
        Notifications.insert({
          "title": "Some title",
          "message": "Some message",
          "show_at": new Date(),
          "userId": Meteor.userId()
        })
      }
    }
  });
}