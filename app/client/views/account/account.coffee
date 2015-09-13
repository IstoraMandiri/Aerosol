Template.account.events
  'click .logout' : ->
    if confirm 'Are you sure?'
      Meteor.logout()