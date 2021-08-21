# frozen_string_literal: true

require_relative '../../models/comment'
require_relative '../../db_connector'

RSpec.describe Comment do
  db_client = create_db_client

  before do
    client = create_db_client
    client.query('set foreign_key_checks = 0')
    client.query('truncate comments')
    client.query('truncate users')
    client.query('set foreign_key_checks = 1')
  end

  describe '#save' do
    it 'saves comment' do
      db_client.query("insert into users (username, email) values ('foo', 'fui@mail.com')")
      user_id = db_client.last_id
      db_client.query("insert into posts (content, user_id) values ('hello', #{user_id})")
      post_id = db_client.last_id

      content_comment = 'this is comment'
      comment = described_class.new(content_comment, nil, post_id, user_id, db_client)

      data = comment.save

      expect(data).to eq({
                           'id' => 1,
                           'content' => content_comment,
                           'attachment' => '',
                           'post_id' => 2,
                           'user_id' => 1
                         })
    end
  end
end
