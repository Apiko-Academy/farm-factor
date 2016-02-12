Router.route 'editDocumentDefinition',
  template: 'DefinitionEditor'
  path: 'definition-editor/:id'
  controller: controllers.Authorized
  waitOn: -> @subscribe 'singleDocumentDefinition', @params.id
  data: ->
    doc: DocumentDefinitions.findOne _id: @params.id
    mode: 'update'


Router.route 'createDocumentDefinition',
  template: 'DefinitionEditor'
  path: 'definition-editor'
  controller: controllers.Authorized
  data: ->
    mode: 'insert'
