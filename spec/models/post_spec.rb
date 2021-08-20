# frozen_string_literal: true

require_relative '../../models/post'
require_relative '../../db_connector'

RSpec.describe Post do
  db_client = create_db_client
  query_insert_user = "INSERT INTO users (username, email, bio) VALUES ('foo', 'foo@mail.com', 'i am foo')"

  before do
    client = create_db_client
    client.query('set foreign_key_checks = 0')
    client.query('truncate users')
    client.query('truncate posts')
    client.query('truncate hashtags')
    client.query('truncate post_hashtags')
    client.query('set foreign_key_checks = 1')
  end

  describe '#save' do
    it 'creates a new post' do
      db_client.query(query_insert_user)
      model = described_class.new('new post', nil, 1, db_client)
      data = model.save

      expect(data).to eq({ 'id' => 1, 'content' => 'new post', 'attachment' => '', 'user_id' => 1 })
    end

    it 'creates a new post with attachment' do
      db_client.query(query_insert_user)
      model = described_class.new('new post', 'test.txt', 1, db_client)

      data = model.save

      expect(data['attachment']).to eq('test.txt')
    end
  end
end
