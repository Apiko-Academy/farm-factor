Router.route 'createDocument',
  template: 'DocumentConstructor'
  path: '/document-constructor'
  controller: controllers.Authorized
  waitOn: -> @subscribe 'documentDefinitions'
  data: ->
    documentDefinitions: DocumentDefinitions.find()