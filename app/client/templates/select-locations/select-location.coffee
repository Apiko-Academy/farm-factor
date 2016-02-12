Template.SelectLocation.helpers
  displayCropsButton: ->
    _.all [
      @type is 'field'
      Roles.userIsInRole Meteor.userId(), ['admin', 'manager']
    ]
  locations: ->
    if Template.instance()._locationFilter.get() is ''
      Locations.find {}
    else
      Locations.find name: Template.instance()._locationFilter.get()
  classType: (type) ->
    switch type
      when "field" then 'mdi-maps-local-florist'
      when "storage" then 'mdi-maps-store-mall-directory'
      when "gasStation" then 'mdi-maps-local-gas-station'
      else
        'mdi-maps-pin-drop'

Template.SelectLocation.events
  'submit #search-form ': (e, tmp) ->
    e.preventDefault()
    tmp._locationFilter.set tmp.$('input').val()

  'click #gps-link ': (e) ->
    e.preventDefault()
    sAlert.info 'Визначення поточних координат'
    setTimeout () ->
      Router.go 'selectJobType', _locationId: 's7LF7LRbWWAShrpu7'
    ,
      1000

Template.SelectLocation.onCreated () ->
  @_locationFilter = new ReactiveVar ''