route = (name, template) ->
  FlowRouter.route name,
    action: ->
      BlazeLayout.render 'defaultLayout',
        main: template
        menu: 'menu'


route '/', 'landing'
route '/registry', 'registry'
route '/create', 'create'
route '/donate', 'donate'
route '/account', 'account'
