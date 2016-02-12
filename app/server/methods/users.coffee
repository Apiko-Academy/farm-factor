Meteor.methods 'userExists': (username) ->
  user = Meteor.users.findOne username: username
  not _.isUndefined user