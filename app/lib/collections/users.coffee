Meteor.users.attachSchema schemas.User


if Meteor.isServer
  Meteor.users.after.update (userId, doc) ->
    hasRoles = _.isArray(doc.roles) and doc.roles.length > 0
    unless hasRoles
      Roles.addUsersToRoles doc, ['worker']
    doc


Meteor.users.allow
  insert: -> true
  update: -> true
  remove: -> true