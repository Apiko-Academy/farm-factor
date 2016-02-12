Router.route 'selectLocation',
  path: 'select-location'
  layout: 'FluidLayout'
  controller: controllers.Authorized
  waitOn: ->
    @subscribe 'locations'