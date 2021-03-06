restify   = require 'restify'
profiling = require './profiling'
logger    = require './logger'


server = restify.createServer({
    name: 'Reputation Service'
})

server.pre (req, res, next) ->
    if req.path().indexOf('/project/') != -1
        req.projectID = req.path().split('/', 3)[2]
        req._path = req.path().substring(req.path().split('/', 3).join('/').length)
    else
        req.projectID = ''
    next()

server.use restify.queryParser()
server.use restify.bodyParser()
server.use require 'connect-requestid'
server.get '/', (req, res, next) ->
    res.send 'Hello World'
    next()

server.post '/users', profiling.addUser
server.get '/users/:user/rank', profiling.getUserRank
server.get '/users/contributionStatistics', profiling.getContributionStatistics

server.post '/activities/perform', profiling.performActivity
server.get '/activities/levels', profiling.getActivityLevels

server.post '/skills', profiling.addSkill
server.del '/skills', profiling.deleteSkill
server.get '/skills/distribution', profiling.skillsDistribution
server.get '/skills/contribution', profiling.skillsContribution
server.get '/skills/userNumber', profiling.userNumber
server.get '/skills/counts', profiling.skillsCounts

server.get '/skills/recommend', profiling.recommendSkills
server.get '/actions/recommend', profiling.recommendActions
server.get '/actionTypes/recommend', profiling.recommendActionTypes

server.on 'uncaughtException', (req, res, route, err) ->
    logger.error 'Uncaught exception! %s', err.stack
    res.send err

server.listen 7171, () ->
    logger.info '%s listening at %s', server.name, server.url
