require 'sinatra'
require_relative './db_connector'
require_relative './controllers/userController'
require_relative './controllers/postController'

db_client = create_db_client

get '/' do
    'Hello world'
end

post '/user' do
    content_type :json
    data = JSON.parse request.body.read
    user_controller = UserController.new(db_client)
    response = user_controller.create(data)
    response
end

post '/user/:id' do
    content_type :json
    data = JSON.parse request.body.read
    user_controller = UserController.new(db_client)
    response = user_controller.update(params['id'], data)
    response
end

post '/user/post/:id' do
    content_type :json
    data = JSON.parse request.body.read
    user_controller = UserController.new(db_client)
    response = user_controller.create_post(params['id'], data)
    response
end

get '/posts' do
    content_type :json
    tag = params[:tag]
    post_controller = PostController.new(db_client)
    response = post_controller.get_post_for_hashtag(tag)
    response
end