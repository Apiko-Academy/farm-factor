@Locations = new Meteor.Collection 'location'


Locations.attachSchema schemas.Location


Locations.allow
  insert: -> true
  update: -> true
  remove: -> true