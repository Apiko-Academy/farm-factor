@Api = new Restivus
  useDefaultAuth: true
  prettyJson: false


Meteor.startup ->
  Api.addCollection Meteor.users
  Api.addCollection Documents
  Api.addCollection DocumentDefinitions
  Api.addCollection Locations
