Router.route '/',
  name: 'home'
  template: 'Home'
  onBeforeAction: ->
    userId = Meteor.userId()
    if not userId
      Router.go 'atSignIn'
    else if Roles.userIsInRole userId, ['worker']
      Router.go 'selectLocation'
    else if Roles.userIsInRole userId, ['admin']
      Router.go 'dashboard'
    @next()