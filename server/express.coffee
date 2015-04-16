# Dependencies
env= require './env'

express= require 'express'
multer= require 'multer'
session= require 'express-session'
SessionStore= require('connect-redis') session
passport= require './passport'
og= require './og'

# Setup express
app= express()
app.use multer inMemory:yes
app.use session
  store: new SessionStore host:'192.168.59.104'
  secret: 'keyboard cat'
  httpOnly: no
  resave: yes
  saveUninitialized: yes
app.use passport.initialize()
app.use passport.session()

app.use (req,res,next)->
  # edgy.website -> edgy.black
  return res.redirect env.PUBLIC_URL if req.headers.host is env.MYPAGE_HOST
  next()

app.use express.static env.PUBLIC+'/public'
app.use '/storage/:key',og.storage
app.use '/storage',express.static env.STORAGE
app.use '/:id',og.artwork_view

module.exports= app