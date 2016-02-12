Router.route 'documentDefinitionsList',
  template: 'DocumentDefinitions'
  controller: controllers.Authorized
  path: '/document-definitions'
  waitOn: -> @subscribe 'documentDefinitions'
  data: ->
    documentDefinitions: DocumentDefinitions.find {}