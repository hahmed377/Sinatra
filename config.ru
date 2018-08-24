require 'sinatra'
require 'sinatra/contrib'
# changes the file without restarting the whole server
require 'sinatra/reloader' if development?
require 'pry'
require 'pg'
require_relative "./models/post.rb"
require_relative "./controllers/post_controllers.rb"
require 'Rack'
# information goes into the body of the request
# create our first route
# get is request word
use Rack::Reloader
use Rack::MethodOverride
# this will direct the request to the correct controller
run PostController
