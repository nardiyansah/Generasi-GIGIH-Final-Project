# frozen_string_literal: true

require 'sinatra'
require_relative './db_connector'
require_relative './controllers/userController'
require_relative './controllers/postController'
require_relative './controllers/hashtagController'
require_relative './helper/url'

db_client = create_db_client
user_controller = UserController.new(db_client)
post_controller = PostController.new(db_client)
hashtag_controller = HashtagController.new(db_client)

get '/' do
  'Hello world'
end

post '/user' do
  content_type :json
  data = JSON.parse request.body.read
  response = user_controller.create(data)
  response
rescue StandardError => e
  return [500, { error: e }.to_json]
end

post '/user/:id' do
  content_type :json
  data = JSON.parse request.body.read
  response = user_controller.update(params['id'], data)
  response
rescue StandardError => e
  return [500, { error: e }.to_json]
end

post '/user/post/:id' do
  content_type :json
  attachment = params[:attachment]

  if attachment.nil?
    data = JSON.parse request.body.read
    response = user_controller.create_post(params['id'], data)
    return response
  else
    accepted_formats = ['.jpg', '.png', '.gif', '.mp4']
    not_accepted_formats = ['.tiff', '.psd', '.eps', '.ai', '.indd', '.raw', '.webm', '.mkv', '.flv', '.vob',
                            '.ogv', '.ogg', '.drc', '.gifv', '.mng', '.avimts', '.m2ts', '.ts', '.wmv', '.yuv', '.rm', '.rmvb', '.viv', '.asf', '.amv', '.mpg', '.mp2', '.mpeg', '.svi', '.3gp', '.3g2', '.mxf', '.roq', '.nsv']
    file_name = File.basename(attachment[:tempfile])
    tempfile = attachment[:tempfile]
    is_accepted_format = accepted_formats.include? File.extname(file_name)
    is_not_accepted_format = not_accepted_formats.include? File.extname(file_name)

    if is_accepted_format || !is_not_accepted_format
      File.open("./public/#{file_name}", 'wb') do |f|
        f.write(tempfile.read)
      end
      file_path = "#{base_url}/#{file_name}"
      data = { 'content' => params[:content], 'hashtags' => params[:hashtags], 'attachment' => file_path }
      response = user_controller.create_post(params['id'], data)
      return response
    else
      return [400, { message: 'file you want to send is not accepted format' }.to_json]
    end
  end
rescue StandardError => e
  return [400, { message: 'bad request, maybe you forget to provide the file', error: e }.to_json]
end

get '/posts' do
  content_type :json
  tag = params[:tag]
  response = post_controller.get_post_for_hashtag(tag)
  response
rescue StandardError => e
  return [500, { error: e }.to_json]
end

post '/comment/:user_id/:post_id' do
  content_type :json
  attachment = params[:attachment]

  if attachment.nil?
    data = JSON.parse request.body.read
  else
    accepted_formats = ['.jpg', '.png', '.gif', '.mp4']
    not_accepted_formats = ['.tiff', '.psd', '.eps', '.ai', '.indd', '.raw', '.webm', '.mkv', '.flv', '.vob',
                            '.ogv', '.ogg', '.drc', '.gifv', '.mng', '.avimts', '.m2ts', '.ts', '.wmv', '.yuv', '.rm', '.rmvb', '.viv', '.asf', '.amv', '.mpg', '.mp2', '.mpeg', '.svi', '.3gp', '.3g2', '.mxf', '.roq', '.nsv']
    file_name = File.basename(attachment[:tempfile])
    tempfile = attachment[:tempfile]
    is_accepted_format = accepted_formats.include? File.extname(file_name)
    is_not_accepted_format = not_accepted_formats.include? File.extname(file_name)

    unless is_accepted_format || !is_not_accepted_format
      return [400, { message: 'file you want to send is not accepted format' }.to_json]
    end

    File.open("./public/#{file_name}", 'wb') do |f|
      f.write(tempfile.read)
    end
    file_path = "#{base_url}/#{file_name}"
    data = { 'content' => params[:content], 'hashtags' => params[:hashtags], 'attachment' => file_path }
  end
  response = user_controller.create_comment(params['user_id'], params['post_id'], data)
  return response
rescue StandardError => e
  return [400, { message: 'bad request, maybe you forget to provide the file', error: e }.to_json]
end

get '/trending_tags' do
  content_type :json
  response = hashtag_controller.get_trending_tags
  response
rescue StandardError => e
  return [500, { error: e }.to_json]
end
