Template.LocationItem.helpers
  query: ->
    "latitude=#{@latitude}&longitude=#{@longitude}"
  latitude: ->
    @latitude.toFixed(6)
  longitude: ->
    @longitude.toFixed(6)