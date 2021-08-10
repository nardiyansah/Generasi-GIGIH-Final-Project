require 'sinatra'
require_relative './db_connector'
require_relative './controllers/userController'

db_client = create_db_client

get '/' do
    'Hello world'
end

post '/users' do
    data = JSON.parse request.body.read
    user_controller = UserController.new(db_client)
    response = user_controller.create(data)
    response
end

# patch '/users/:id' do
    
# end