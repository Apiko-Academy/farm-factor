AutoForm.addHooks 'updateCropsHistory',
  onSuccess: () ->
    sAlert.success 'Дані успішно збережено.'
  onError: (action, error) ->
    sAlert.error error.message