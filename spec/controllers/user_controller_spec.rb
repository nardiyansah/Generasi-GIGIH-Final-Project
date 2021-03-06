# frozen_string_literal: true

require_relative '../../controllers/user_controller'
require_relative '../../db_connector'
require 'mysql2'

RSpec.describe UserController do
  db_client = create_db_client

  before do
    client = create_db_client
    client.query('set foreign_key_checks = 0')
    client.query('truncate users')
    client.query('truncate posts')
    client.query('truncate comments')
    client.query('truncate hashtags')
    client.query('truncate post_hashtags')
    client.query('truncate comment_hashtags')
    client.query('set foreign_key_checks = 1')
  end

  describe '#create' do
    it 'creates account' do
      data = { 'username' => 'foo', 'email' => 'foo@mail.com' }
      controller = described_class.new(db_client)

      controller.create(data)
      id = db_client.last_id

      stored_data = db_client.query("SELECT * FROM users WHERE id = #{id}").each[0]

      expect(stored_data).to eq({ 'id' => 1, 'username' => 'foo', 'email' => 'foo@mail.com', 'bio' => '' })
    end

    it 'cannots create acount with same email' do
      data = { 'username' => 'foo', 'email' => 'foo@mail.com' }
      controller = described_class.new(db_client)

      controller.create(data)
      status = controller.create(data)

      expect(status).to eq([406, "can't save data, maybe the data is already exist"])
    end

    it 'does not accept request withoud data' do
      controller = described_class.new(db_client)

      status = controller.create(nil)
      expect(status).to eq([400, 'missing data. please sure you already give username and email'])
    end
  end

  describe '#update' do
    it 'changes data account with specific id' do
      data = { 'username' => 'foo', 'email' => 'foo@mail.com' }
      controller = described_class.new(db_client)

      controller.create(data)

      id = db_client.last_id
      data['bio'] = 'i am foo'

      status = controller.update(id, data)

      expect(status).to eq([
                             200,
                             {
                               message: 'data has been updated',
                               username: data['username'],
                               bio: data['bio']
                             }.to_json
                           ])
    end
  end

  describe '#create_post' do
    it 'creates post with specific user id' do
      content = { 'content' => 'my first post' }
      controller = described_class.new(db_client)

      db_client.query("INSERT INTO users (username, email) VALUES ('fii', 'fii@mail.com')")
      user_id = db_client.last_id

      data = controller.create_post(user_id, content)

      expect(data).to eq([
                           201,
                           {
                             message: 'success create a post',
                             user_id: user_id,
                             user_name: 'fii',
                             post_id: 1,
                             content: 'my first post',
                             attachment: '',
                             tags: []
                           }.to_json
                         ])
    end

    it 'creates post with one hashtag' do
      content = { 'content' => 'my first post', 'hashtags' => ['ame'] }
      controller = described_class.new(db_client)

      db_client.query("INSERT INTO users (username, email) VALUES ('fii', 'fii@mail.com')")
      user_id = db_client.last_id

      data = controller.create_post(user_id, content)

      expect(data).to eq([
                           201,
                           {
                             message: 'success create a post',
                             user_id: user_id,
                             user_name: 'fii',
                             post_id: 1,
                             content: 'my first post',
                             attachment: '',
                             tags: [{ id: 1, tag: 'ame', amount: 1 }]
                           }.to_json
                         ])
    end
  end

  describe '#create_comment' do
    it 'creates comment with specific id' do
      content = { 'content' => 'my first comment' }
      controller = described_class.new(db_client)

      db_client.query("INSERT INTO users (username, email) VALUES ('fii', 'fii@mail.com')")
      user_id = db_client.last_id
      db_client.query("insert into posts (content, user_id) values ('post', #{user_id})")
      post_id = db_client.last_id

      data = controller.create_comment(user_id, post_id, content)

      expect(data).to eq([
                           201,
                           {
                             message: 'success create a comment',
                             user_id: user_id,
                             user_name: 'fii',
                             comment_id: 1,
                             content: 'my first comment',
                             attachment: '',
                             tags: []
                           }.to_json
                         ])
    end

    it 'creates comment with one hashtag' do
      content = { 'content' => 'my first comment', 'hashtags' => ['ame'] }
      controller = described_class.new(db_client)

      db_client.query("INSERT INTO users (username, email) VALUES ('fii', 'fii@mail.com')")
      user_id = db_client.last_id
      db_client.query("insert into posts (content, user_id) values ('post', #{user_id})")
      post_id = db_client.last_id

      data = controller.create_comment(user_id, post_id, content)

      expect(data).to eq([
                           201,
                           {
                             message: 'success create a comment',
                             user_id: user_id,
                             user_name: 'fii',
                             comment_id: 1,
                             content: 'my first comment',
                             attachment: '',
                             tags: [{ id: 1, tag: 'ame', amount: 1 }]
                           }.to_json
                         ])
    end
  end
end
