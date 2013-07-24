root = exports ? this

Meteor.publish "notifications", ()->

  Notifications.find({
    userId: @['userId']
    show: true
  })

Meteor.startup ()->
  lastTime = new Date()
  Meteor.setInterval(
    ()->
      Notifications.update(
        {
          show_at: {
            $gte: lastTime
            $lt: new Date()
          }
          show:  { $exists: false }
          shown: { $exists: false }
        }
        ,
        {
          $set: {
            show : true
          }
        }
      )
      lastTime = new Date()
    ,
    1000
  )