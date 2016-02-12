Template.DocumentEditor.helpers
  location: (_id) ->
    location = Locations.findOne _id
    location?.name
  user: (_id) ->
    users = Meteor.users.findOne _id
    users.profile.name
  inputType: (type) ->
    inputTypes =
      String: 'text'
      Number: 'number'
      Date: 'date'
    inputTypes[type]


Template.DocumentEditor.events
  'submit form': (e, tpl) ->
    e.preventDefault()
    doc = @doc
    controls = tpl.findAll 'input'
    _.each controls, (control) ->
      if control.disabled then return
      _.each doc.fields, (field) ->
        unless field.label is control.id then return
        console.log 'field =>', control.id
        field.value = control.value
    Documents.update _id: doc._id,
      $set: fields: doc.fields
    ,
      (err) ->
        if err
          sAlert.error err.message
        else
          sAlert.success 'Дані успішно збережено.'