Router.route 'locations',
  path: '/locations'
  controller: controllers.Authorized
  layout: 'FluidLayout'
  onBeforeAction: ->
    GoogleMaps.load()
    @next()