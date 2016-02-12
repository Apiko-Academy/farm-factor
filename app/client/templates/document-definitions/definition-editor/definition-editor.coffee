AutoForm.addHooks 'documentDefinitionsEditor',
  onSuccess: () ->
    Router.go 'documentDefinitionsList'
  onError: (action, error) ->
    sAlert.error error.message