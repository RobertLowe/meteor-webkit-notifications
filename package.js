Package.describe({
  summary: "A simple wrapping for Webkit Notifications"
});

Package.on_use( function(api) {
  api.use('coffeescript', 'server');

  api.add_files('notifications_server.coffee', 'server');
  api.add_files('notifications_client.coffee', 'client');
  api.add_files('notifications.coffee', ['client', 'server']);
});
