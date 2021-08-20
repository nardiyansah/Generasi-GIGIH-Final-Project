# frozen_string_literal: true

require_relative '../../models/hashtag'
require_relative '../../db_connector'

RSpec.describe 'hashtag model' do
  db_client = create_db_client

  before do
    client = create_db_client
    client.query('set foreign_key_checks = 0')
    client.query('truncate hashtags')
    client.query('truncate comment_hashtags')
    client.query('truncate post_hashtags')
    client.query('truncate comments')
    client.query('truncate posts')
    client.query('truncate users')
    client.query('set foreign_key_checks = 1')
  end

  describe '#save' do
    it 'shoulds save one hashtag' do
      hashtag = ['ame']
      model = Hashtag.new(hashtag, db_client)

      stored_hashtag = model.save

      expect(stored_hashtag[0]['tag']).to eq('ame')
    end

    it 'saves two hashtag' do
      hashtag = %w[ame agari]
      model = Hashtag.new(hashtag, db_client)

      stored_hashtag = model.save

      expect(stored_hashtag).to eq([
                                     { 'amount' => 1, 'id' => 1, 'tag' => 'ame' },
                                     { 'amount' => 1, 'id' => 2, 'tag' => 'agari' }
                                   ])
    end

    it 'saves one hashtags because there is empty string' do
      hashtag = ['ame', '']
      model = Hashtag.new(hashtag, db_client)

      stored_hashtag = model.save

      expect(stored_hashtag[0]).to eq({ 'amount' => 1, 'id' => 1, 'tag' => 'ame' })
    end
  end

  describe '#get_trending' do
    it 'returns 5 top trending hashtags' do
      db_client.query("insert into users (username, email) values ('foo', 'foo@mail.com')")
      user_id = db_client.last_id
      db_client.query("insert into posts (content, user_id) values ('this is post', #{user_id})")
      post_id = db_client.last_id
      db_client.query("insert into comments (content, post_id, user_id) values ('this is comment', #{post_id}, #{user_id})")
      comment_id = db_client.last_id

      db_client.query("insert into hashtags (tag, amount) values ('ame', 1) on duplicate key update amount = values(amount) + 1")
      tag1 = db_client.last_id

      db_client.query("insert into hashtags (tag, amount) values ('agari', 1) on duplicate key update amount = values(amount) + 1")
      tag2 = db_client.last_id

      i = 0
      until i > 5
        db_client.query("insert into hashtags (tag, amount) values ('ame', 1) on duplicate key update amount = values(amount) + 1")
        db_client.query("insert into post_hashtags (post_id, hashtag_id) values (#{post_id}, #{tag1})")
        i += 1
      end

      i = 0
      until i > 3
        db_client.query("insert into hashtags (tag, amount) values ('agari', 1) on duplicate key update amount = values(amount) + 1")
        db_client.query("insert into comment_hashtags (comment_id, hashtag_id) values (#{comment_id}, #{tag2})")
        i += 1
      end

      trending_tag = Hashtag.get_trending(db_client)

      expect(trending_tag[0]).to eq({ 'hashtag_id' => 1, 'tag' => 'ame', 'amount' => 6 })
    end
  end
end
