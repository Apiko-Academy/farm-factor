Meteor.startup ->
  sAlert.config
    effect: 'genie'
    position: 'top-right'
    timeout: 2000
    html: false
    onRouteClose: true
    stack: true
    offset: 60