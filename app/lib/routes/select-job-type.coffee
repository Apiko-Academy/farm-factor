Router.route 'selectJobType',
  path: '/select-job-type/:_locationId'
  template: 'SelectJobType'
  controller: controllers.Authorized
  waitOn: ->
    @subscribe 'documentsByLocation', @params._locationId
