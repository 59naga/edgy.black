app= angular.module 'app',[
  'ui.router'
  
  'ngAnimate'
  'angularFileUpload'
  'angularMoment'

  'ngReel'
  'jaggy'
  'webcolor'

  'ngStorage'
  'pascalprecht.translate'
]

(require './lib/i18n').client app
(require './lib/storage').client app
(require './lib/routes').client app

app.run (
  $rootScope
  $templateCache

  $state
  $stateParams

  $window
  $timeout
  $webcolorLoadingBar

  amMoment
  $localStorage
)->
  $rootScope.$state= $state
  $rootScope.$stateParams= $stateParams

  $rootScope.back= ->
    $window.history.back()
  $rootScope.goto= (stateName)->
    try
      $state.transitionTo stateName,$state.params
    catch
      return
  $rootScope.location= (url)->
    $window.location.href= url

  $rootScope.pullToRefresh= no
  $window.addEventListener 'scroll',->
    $rootScope.scrollY= $window.scrollY
    $rootScope.$apply()

    if not $rootScope.pullToRefresh and $rootScope.scrollY < -60
      $rootScope.pullToRefresh= yes

      $state.reload()
  $rootScope.$on '$stateChangeStart',(event)->

    $webcolorLoadingBar.start()
  $rootScope.$on '$stateChangeSuccess',->
    $webcolorLoadingBar.complete()
    $timeout (->$rootScope.pullToRefresh= no),1000
  $rootScope.$on '$stateChangeError',(event,toState,toParams,fromState,fromParams,error)->
    $webcolorLoadingBar.complete()
    $state.go 'error' if error.status is 404
  $rootScope.$on '$viewContentLoaded',->
    $templateCache.removeAll()

  if not $localStorage.i18n?
    $localStorage.i18n=
    if navigator.language.slice(0,2) is 'ja'
      'ja'
    else
      'en'
  amMoment.changeLocale $localStorage.i18n

  timezone= 'America/New_York'
  timezone= 'Asia/Tokyo' if $localStorage.i18n is 'ja'
  amMoment.changeTimezone timezone
