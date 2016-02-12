Meteor.startup ->
  # Configure Kadira
  Kadira.connect 'NEAjtyedWTfSPAYoy', '1bef33e3-54b4-4671-a95d-447381de259f'
  
  # Users movements
  Meteor.setInterval ->
    Meteor.users.find(roles: 'worker').forEach (user) ->
      step = 0.00001
      latitude = parseFloat user.profile.location.latitude
      longitude = parseFloat user.profile.location.longitude
      Meteor.users.update _id: user._id,
        $set:
          'profile.location.latitude': latitude + step + ''
          'profile.location.longitude': longitude + step + ''
  , 2000
