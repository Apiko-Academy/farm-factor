Template.WorkerItem.helpers
  query: ->
    latitude = "latitude=#{@profile.location.latitude}"
    longitude = "longitude=#{@profile.location.longitude}"
    "#{latitude}&#{longitude}"
  latitude: ->
    @profile.location.latitude.toFixed(6)
  longitude: ->
    @profile.location.longitude.toFixed(6)