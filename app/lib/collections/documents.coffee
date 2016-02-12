@Documents = new Meteor.Collection 'documents',
  transform: (doc) ->
    doc.fields = _.map doc.fields, (field) ->
      if _.isString field.defaultValue
        try
          field.defaultValue = EJSON.parse field.defaultValue
      if _.isString field.value
        try
          field.value = EJSON.parse field.value
      field
    doc


Documents.attachSchema schemas.Document


Documents.allow
  insert: -> true
  update: -> true
  remove: -> true