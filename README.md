# Meteor Webkit Notifications

Meteor Webkit Notifications provides reactive, webkit notifications for [Meteor](http://www.meteor.com/) applications.

## Installation

Meteor Webkit Notifications can be installed with [Meteorite](https://github.com/oortcloud/meteorite/). From inside a Meteorite-managed app:

``` sh
$ mrt add webkit-notifications
```

Note that version 0.1.0 works with Meteor 0.6.4 and later.

## API

### Setup

Request permissions from the browser:

``` coffeescript
Template.exampleTemplate.events
  "click .some-button": ()->
    window.webkitNotifications.requestPermission()
```

### Basics

Create a new notification in the future:

``` coffeescript
Notifications.insert({
  title: "Some title"
  message: "Some message"
  show_at: new Date()
  userId: Meteor.userId()
})
```


Detect a click?:
``` coffeescript
# server
Meteor.publish ()->
  Notifications.find({
    clicked: true
    userId: @userId
  })

# client
Notification.find(
  clicked: true
  userId: Meteor.userId()
).observe
  added: (notification)
    Meteor._debug "click notification:", notification
    # do some work and clean up
    Notifications.remove(notification._id)
```

## Security

No security is implemented, you'll need to configure your own policies.

## Contributing

To run the tests, ensure that the webkit-notifications is checked out to a folder called `webkit-notifications`, and then simply run:

``` sh
$ mrt test-packages webkit-notifications
```