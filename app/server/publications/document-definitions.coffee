Meteor.publish 'documentDefinitions', () ->
  DocumentDefinitions.find()

  
Meteor.publish 'singleDocumentDefinition', (id) ->
  DocumentDefinitions.find _id: id