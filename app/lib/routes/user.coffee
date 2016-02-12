AccountsTemplates.configureRoute 'signIn',
  layoutTemplate: 'Layout'


AccountsTemplates.configureRoute 'signUp',
  layoutTemplate: 'Layout'


Router.route 'userProfile',
  controller: controllers.Authorized
  path: 'profile/:id?'
  waitOn: ->
    if @params.id
      @subscribe 'singleUser', @params.id
  data: ->
    if @params.id
      user = Meteor.users.findOne @params.id
    else
      user = Meteor.user()
    user: user
