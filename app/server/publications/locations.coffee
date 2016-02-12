Meteor.publish 'singleLocations', (_id) ->
  Locations.find _id: _id

Meteor.publish 'locations', () ->
  Locations.find()