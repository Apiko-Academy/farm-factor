@DocumentDefinitions = new Meteor.Collection 'documentDefinitions',
  transform: (doc) ->
    doc.fields = _.map doc.fields, (field) ->
      if _.isString field.defaultValue
        try
          field.defaultValue = EJSON.parse field.defaultValue
      field
    doc


@DocumentDefinitions.attachSchema schemas.DocumentDefinition


@DocumentDefinitions.allow
  insert: -> true
  update: -> true
  remove: -> true