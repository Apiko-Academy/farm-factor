Meteor.publish 'users', () ->
  Meteor.users.find()


Meteor.publish 'singleUser', (id) ->
  Meteor.users.find _id: id
