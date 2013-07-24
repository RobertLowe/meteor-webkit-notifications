Meteor.startup ()->

  Deps.autorun ()->

    if window.webkitNotifications.checkPermission() == 0 && Meteor.userId()
      Meteor.subscribe("notifications")

      Notifications.find(show: true, shown: {$exists: false}, userId: Meteor.userId()).observe
        # notification only added when show:true
        # we tick on the server every 5 seconds and update the past notification show:true
        added: (notification)->
          browser_notification = window.webkitNotifications.createNotification(notification.icon, notification.title, notification.message)

          browser_notification.onclose = ()->
            Notifications.update(notification._id, {$set: {closed: true}})

          browser_notification.ondisplay = ()->
            Notifications.update(notification._id, {$set: {displayed: true}})

          browser_notification.onclick = ()->
            Notifications.update(notification._id, {$set: {clicked: true}})

          browser_notification.onerror = ()->
            Notifications.update(notification._id, {$set: {error: true}})

          browser_notification.show()
          Notifications.update(notification._id, {$set: {shown: true}})
