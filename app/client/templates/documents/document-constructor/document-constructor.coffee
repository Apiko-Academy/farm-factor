Template.DocumentConstructor.events
  'submit form': (e, tpl) ->
    e.preventDefault()
    control = tpl.find '#docTemplate'
    doc = DocumentDefinitions.findOne control.value
    doc.value = doc.defaultValue
    Documents.insert doc, (err, res) ->
      if err
        sAlert.error err.message
      else
        Router.go 'editDocument', id: res