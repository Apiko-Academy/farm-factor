compositeLocation =
  find: (document) ->
    locationFields = document.fields.filter (field) -> field.type is 'Location'
    locationIds = locationFields.map (field) -> field.value
    Locations.find _id: $in: locationIds


compositeUsers =
  find: (document) ->
    userFields = document.fields.filter (field) -> field.type is 'User'
    userIds = userFields.map (field) -> field.value
    Meteor.users.find _id: $in: userIds


Meteor.publish 'documentsGroup', (doc) ->
  filter = _.keys schema.rawDocumentDefinitionField
  filter = _.map filter, (key) ->
    _.object [
      "fields.#{key}"
      doc.fields[key]
    ]
  filter = _.extend name: doc.name, filter
  Documents.find filter


Meteor.publishComposite 'documents', ->
  find: -> Documents.find()
  children: [compositeLocation, compositeUsers]


Meteor.publishComposite 'documentsByLocation', (locationId) ->
  find: ->
    Documents.find 'fields.type': 'Location', 'fields.value': locationId
  children: [compositeLocation, compositeUsers]


Meteor.publishComposite 'singleDocument', (id) ->
  find: -> Documents.find {_id: id}
  children: [compositeLocation, compositeUsers]
