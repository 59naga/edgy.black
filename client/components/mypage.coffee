module.exports.client= (
  $scope

  user
)->
  $scope.user= user.data
  $scope.states= 
    'mypage.index':
      icon: 'icons/desk.gif'
      title: 'マイページ'
    'http://localhost.com:59798':
      icon: 'icons/search.gif'
      title: 'トップへ'

module.exports.resolve=
  user: (mypageId,$http,$state)->
    return $state.go 'error' if location.hostname.split('.').length<= 2
    $http.get '/mypage/user/?mypage_id='+mypageId

  artworks: (user,$http)->
    $http.get '/front/artworks/'+user.data.id