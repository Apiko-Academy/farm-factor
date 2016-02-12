Template.Locations.events
  'click a.coordinates': (e, t) ->
    t.coordinatesAutorun.invalidate()

Template.Locations.helpers
  locations: ->
    Locations.find()

  workers: ->
    Meteor.users.find({ roles: 'worker' })
    
  mapOptions: ->
    query = Router.current().params.query;
    # Make sure the maps API has loaded
    if GoogleMaps.loaded()
      # Map initialization options
      return {
        center: new (google.maps.LatLng)(query.latitude || 49.505487, query.longitude || 25.075127)
        zoom: 14
        mapTypeId: google.maps.MapTypeId.SATELLITE
      }

Template.Locations.onCreated ->
  self = @

  @subscribe 'locations'
  @subscribe 'users'
  
  GoogleMaps.ready 'locationsMap', (map) ->
    self.map = map
    markers =
      workers: {}
      locations: {}
    infoWindows = 
      workers: {}
      locations: {}

    # drawing library
    google.maps.__gjsload__('drawing', '\'use strict\';function Zy(a){var b=this;a=a||{};a.drawingMode=a.drawingMode||null;b.setValues(a);K("drawing_impl",function(a){new a.Ok(b)})}w(Zy,H);Kc(Zy.prototype,{map:re,drawingMode:$b});me.drawing=function(a){eval(a)};ta.google.maps.drawing={DrawingManager:Zy,OverlayType:{MARKER:"marker",POLYGON:"polygon",POLYLINE:"polyline",RECTANGLE:"rectangle",CIRCLE:"circle"}};Bc("drawing",{});\n')
    
    figureOptions = 
      fillColor: '#FBC500'
      fillOpacity: 0.2
      strokeWeight: 2
      strokeColor: '#FBC500'
      clickable: true
      editable: true
      zIndex: 1

    # Add a marker to the map once it's ready
    self.autorun ->
      Meteor.users.find(roles: 'worker').forEach (user) ->
        if user.profile.location.latitude and user.profile.location.longitude
          if !markers.workers[user._id]

            markers.workers[user._id] = new (google.maps.Marker)(
              position: new (google.maps.LatLng)(user.profile.location.latitude, user.profile.location.longitude)
              icon: '/markers/transport.png'
              map: map.instance)

            infoWindows.workers[user._id] = new (google.maps.InfoWindow)(
              content: '<div id="content">'+
                '<div id="siteNotice">'+
                '</div>'+
                '<img width="48" style="margin-right: 14px; vertical-align: sub; display: inline-block;" src="http://icons.iconarchive.com/icons/webalys/kameleon.pics/512/Farmer-icon.png">' +
                '<h1 id="firstHeading" class="firstHeading" style="display: inline-block;">' + user.profile.name + '</h1>'+
                '<div id="bodyContent">'+
                '<p>' + user.profile.name + ' - дуже важлива людина в підприємстві. Володіє навичками керування усіма транспортними засобами та прогнозування погоди на тиждень вперед на основі власних фізіологічних даних.</p>'+
                '<p>Телефон: 0977777777</p>'+
                '</div>'+
                '</div>'
            )
            
            marker = markers.workers[user._id]
            infoWindow = infoWindows.workers[user._id]

            marker.addListener('click', -> 
              infoWindow.open(map.instance, marker);
            )
          else
            markers.workers[user._id].setPosition(new (google.maps.LatLng)(user.profile.location.latitude, user.profile.location.longitude))

    self.autorun ->
      Locations.find().forEach (location) ->
        if location.latitude and location.longitude
          if !markers.locations[location._id]
            icon = 'places.png'
            if location.type is 'storage'
              icon = 'government.png'
            if location.type is 'field'
              icon = 'places.png'
            if location.type is 'gasStation'
              icon = 'automotive.png'
            markers.locations[location._id] = new (google.maps.Marker)(
              position: new (google.maps.LatLng)(location.latitude, location.longitude)
              icon: '/markers/' + icon
              map: map.instance)
            if location.type is 'field'
              infoWindows.locations[location._id] = new (google.maps.InfoWindow)(
                content: '<div id="content">'+
                  '<div id="siteNotice">'+
                  '</div>'+
                  '<h1 id="firstHeading" class="firstHeading" style="display: inline-block;">' + location.name + '</h1>'+
                  '<div id="bodyContent">'+
                  '<p>' + location.description + '</p>'+
                  '<p><a href="/crops-history/' + location._id + '" target="_blank">Відкрити історію посівів</a></p>'+
                  '</div>'+
                  '</div>'
              )

              marker = markers.locations[location._id]
              infoWindow = infoWindows.locations[location._id]

              marker.addListener('click', -> 
                infoWindow.open(map.instance, marker);
              )

              triangleCoords = [
                {
                  lat: location.latitude + 0.0094
                  lng: location.longitude - 0.0045
                }
                {
                  lat: location.latitude - 0.0050 #bottom-left
                  lng: location.longitude - 0.012
                }
                {
                  lat: location.latitude - 0.0095
                  lng: location.longitude + 0.0052
                }
                {
                  lat: location.latitude + 0.0050
                  lng: location.longitude + 0.013
                }
              ]
              # Construct the polygon.
              polygon = new (google.maps.Polygon)(
                _.extend {
                  paths: triangleCoords
                  map: map.instance
                }, figureOptions  
              )
          else
            markers.locations[location._id].setPosition(new (google.maps.LatLng)(location.latitude, location.longitude))
    
    self.coordinatesAutorun = self.autorun ->
      query = Router.current().params.query

      if query.latitude and query.longitude
        map.instance.setCenter(new (google.maps.LatLng)(query.latitude, query.longitude))
    
    drawingManager = new (google.maps.drawing.DrawingManager)(
      drawingMode: null
      drawingControl: true
      map: map.instance
      drawingControlOptions:
        position: google.maps.ControlPosition.TOP_RIGHT
        drawingModes: [
          google.maps.drawing.OverlayType.MARKER
          google.maps.drawing.OverlayType.POLYGON
          google.maps.drawing.OverlayType.RECTANGLE
        ]
      # markerOptions: icon: 'images/beachflag.png'
      polygonOptions: figureOptions
      rectangleOptions: figureOptions
    ) 

    kmlLayer = new google.maps.KmlLayer
      url: 'http://kml-samples.googlecode.com/svn/trunk/kml/Region/polygon-swap-pop.kml',
      map: map.instance

Template.Locations.onRendered ->
  GoogleMaps.load
    v: '3'
    libraries: 'drawing'
