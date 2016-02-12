Router.route 'dashboard',
  controller: controllers.Authorized
  path: '/dashboard'
  waitOn: ->
    @subscribe 'documents'