Router.route 'documents',
  controller: controllers.Authorized
  path: '/documents'
  waitOn: -> @subscribe 'documents'
  data: -> documents: Documents.find()