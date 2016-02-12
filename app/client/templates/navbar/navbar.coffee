Template.Navbar.events
  'click [data-action="sign-out"]': ->
    Meteor.logout()