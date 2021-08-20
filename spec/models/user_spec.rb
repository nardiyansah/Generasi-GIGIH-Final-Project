# frozen_string_literal: true

require_relative '../../models/user'
require_relative '../../db_connector'

RSpec.describe 'user model' do
  db_client = create_db_client
  username = 'foo'
  email = 'foo@mail.com'

  user = User.new(username, email, nil, nil, db_client)

  before do
    client = create_db_client
    client.query('set foreign_key_checks = 0')
    client.query('truncate users')
    client.query('set foreign_key_checks = 1')
  end

  describe '#save' do
    it 'saves new user account' do
      user_id = user.save

      expect(user_id).to eq(user.id)
    end

    it 'stores bio if registered with bio' do
      bio = 'I am foo'

      user = User.new(username, email, bio, nil, db_client)
      user_id = user.save

      stored_bio = db_client.query("SELECT bio FROM users WHERE id = #{user_id}").each[0]['bio']

      expect(stored_bio).to eq(bio)
    end

    it 'does not store data user if already exist in database' do
      user.save
      second_insert = user.save

      # id zero mean  can't insert to database, based on email
      expect(second_insert).to eq(0)
    end
  end

  describe '#update' do
    it 'update user with specific id' do
      user.save
      user.username = 'papa'
      user.update
      stored_username = db_client.query("SELECT username FROM users WHERE id = #{user.id}").each[0]['username']
      expect(stored_username).to eq('papa')
    end
  end
end
