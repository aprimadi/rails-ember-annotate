# For more information see: http://emberjs.com/guides/routing/

if window.location.pathname.match(/^\/images\/[0-9a-z]+$/)
  App.Router.map ()->
    @route('image', { path: '/' })

