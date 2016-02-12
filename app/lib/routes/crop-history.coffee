Router.route 'cropsHistory',
  path: 'crops-history/:id'
  controller: controllers.Authorized
  waitOn: -> @subscribe 'singleLocations', @params.id
  data: ->
    doc: Locations.findOne _id: @params.id
