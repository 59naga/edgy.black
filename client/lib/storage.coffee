module.exports.client= (app)->
  app.directive 'storage',($http,$compile)->
    replace: yes
    link: (scope,element,attrs)->
      {key}= attrs

      $http.get '/storage_url/'+key
      .then (result)->
        url= result.data
        element.html '<img ng-src="'+url+'" jaggy>'
        $compile(element.contents())(scope)
      .catch (error)->
        console.log error
        
        element.html '<img ng-src="notfound" jaggy>'
        $compile(element.contents())(scope)

module.exports.server= (app)->
  db= require process.env.DB_ROOT

  app.get '/storage_url/:key',(req,res)->
    {key}= req.params

    {Storage}= db.models
    Storage.find
      where: {key}
    .then (storage)->
      res.end storage?.url
    .catch (error)->
      res.status 404
      res.json error.message