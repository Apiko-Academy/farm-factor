Router.route 'editDocument',
  template: 'DocumentEditor'
  path: '/document-editor/:id'
  controller: controllers.Authorized
  waitOn: -> @subscribe 'singleDocument', @params.id
  data: ->
    doc: Documents.findOne _id: @params.id