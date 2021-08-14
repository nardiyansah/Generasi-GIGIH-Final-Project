require 'sinatra'
require_relative './db_connector'
require_relative './controllers/userController'
require_relative './controllers/postController'
require_relative './controllers/hashtagController'
require_relative './helper/url'

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
    attachment = params['attachment']

    if attachment.nil?
        data = JSON.parse request.body.read
        user_controller = UserController.new(db_client)
        response = user_controller.create_post(params['id'], data)
        return response
    else
        accepted_formats = [".jpg", ".png", ".gif", ".mp4"]
        file_name = File.basename(attachment[:tempfile])
        tempfile = attachment[:tempfile]
        is_accepted = accepted_formats.include? File.extname(file_name)
        
        if is_accepted
            File.open("./public/#{file_name}", 'wb') do |f|
                f.write(tempfile.read)
            end
            file_path = "#{base_url}/#{file_name}"
            data = {content: params[:content], hashtags: params[:hashtags], attachment: file_path}
            user_controller = UserController.new(db_client)
            response = user_controller.create_post(params['id'], data)
            return response
        end
    end
end

get '/posts' do
    content_type :json
    tag = params[:tag]
    post_controller = PostController.new(db_client)
    response = post_controller.get_post_for_hashtag(tag)
    response
end

post '/comment/:user_id/:post_id' do
    content_type :json
    data = JSON.parse request.body.read
    user_controller = UserController.new(db_client)
    response = user_controller.create_comment(params['user_id'], params['post_id'], data)
    response
end

get '/trending_tags' do
    content_type :json
    hashtag_controller = HashtagController.new(db_client)
    response = hashtag_controller.get_trending_tags
    response
end