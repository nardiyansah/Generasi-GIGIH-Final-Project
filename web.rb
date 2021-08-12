require 'sinatra'
require_relative './db_connector'
require_relative './controllers/userController'

db_client = create_db_client

get '/' do
    'Hello world'
end

post '/user' do
    data = JSON.parse request.body.read
    user_controller = UserController.new(db_client)
    response = user_controller.create(data)
    response
end

post '/user/:id' do
    data = JSON.parse request.body.read
    user_controller = UserController.new(db_client)
    response = user_controller.update(params['id'], data)
    response
end

post '/user/post/:id' do
    data = JSON.parse request.body.read
    user_controller = UserController.new(db_client)
    response = user_controller.create_post(params['id'], data)
    response
end