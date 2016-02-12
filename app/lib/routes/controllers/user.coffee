class Authorized extends RouteController
  onBeforeAction: () ->
    if Meteor.userId()
      @next()
    else
      Router.go 'home'


Namespace 'controllers', Authorized: Authorized