# frozen_string_literal: true

require_relative '../../controllers/post_controller'
require_relative '../../db_connector'

RSpec.describe PostController do
  db_client = create_db_client
  username = 'foo'
  email = 'foo@mail.com'
  bio = 'i am foo'
  content = 'hello world'
  tag = 'tags'

  query_insert_user = "insert into users (username, email, bio) values ('#{username}', '#{email}', '#{bio}')"
  query_insert_post = "insert into posts (content, user_id) values ('#{content}', 1)"
  query_insert_hashtag = "insert into hashtags (tag, amount) values ('#{tag}', 1)"
  query_post_hashtag = 'insert into post_hashtags (post_id, hashtag_id) values (1, 1)'

  before do
    client = create_db_client
    client.query('set foreign_key_checks = 0')
    client.query('truncate users')
    client.query('truncate posts')
    client.query('truncate hashtags')
    client.query('truncate post_hashtags')
    client.query('set foreign_key_checks = 1')
  end

  describe '#get_post_for_hashtag' do
    it 'returns all post for the given tag' do
      db_client.query(query_insert_user)
      db_client.query(query_insert_post)
      db_client.query(query_insert_hashtag)
      db_client.query(query_post_hashtag)

      post_controller = described_class.new(db_client)
      posts = post_controller.get_post_for_hashtag(tag)

      expect(posts[0]).to eq(200)
    end
  end
end
