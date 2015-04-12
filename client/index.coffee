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

app.constant 'components',
  'front.index': '/'

  'front.add': '/add'
  'front.view': '/{id:[0-9]+}'
  'front.edit': '/{id:[0-9]+}/edit'
  'front.remove': '/{id:[0-9]+}/remove'
  
  'front.timeline': '/timeline'
  
  'front.mypage': '/mypage'
  'front.mypage.stats': '/stats/:type'
  'front.mypage.edit': '/edit'
  'front.mypage.quit': '/quit'

  'mypage.index': '/'
app.constant 'mypageId',location.hostname.split('.')[0]

(require './lib/i18n').client app
(require './lib/storage').client app
(require './lib/routes').client app

app.run (
  $rootScope

  $state
  $stateParams

  $window
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
    setTimeout (->pullToRefresh= no),1000
  $rootScope.$on '$stateChangeError',(event,toState,toParams,fromState,fromParams,error)->
    $webcolorLoadingBar.complete()
    $state.go 'error' if error.status is 404

  locale= 'en'
  locale= 'ja' if navigator.language.slice(0,2) is 'ja'
  amMoment.changeLocale $localStorage.i18n or locale
