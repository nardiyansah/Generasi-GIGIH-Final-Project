require_relative '../../models/user'
require_relative '../../db_connector'

RSpec.describe 'user model' do
    db_client = create_db_client
    username = 'foo'
    email = 'foo@mail.com'
    user = User.new(username, email)

    before(:each) do
        client = create_db_client
        client.query('set foreign_key_checks = 0')
        client.query('truncate users')
        client.query('set foreign_key_checks = 1')
    end

    describe "initialize object class" do

        it 'should has username' do
            expect(user.username).to eq(username)
        end

        it 'should has email' do
            expect(user.email).to eq(email)
        end

        it 'bio can be nil' do
            expect(user.bio).to be(nil)
        end

        it 'can contain bio' do
            bio = 'onegaishimasu'
            user = User.new(username, email, bio)

            expect(user.bio).to eq(bio)
        end

        it 'id can be nil' do
            expect(user.id).to be(nil)
        end

        it 'can contain id' do
            bio = 'onegaishimasu'
            id = 1
            user = User.new(username, email, bio, id)

            expect(user.id).to eq(id)
        end
    end

    describe "create new user" do
        
        it 'should save new user account' do
            user = User.new(username, email, nil, nil, db_client)
            user_id = user.save

            expect(user_id).to eq(1)
        end

        it 'should store bio if registered with bio' do
            bio = 'I am foo'

            user = User.new(username, email, bio, nil, db_client)
            user_id = user.save

            stored_bio = db_client.query("SELECT bio FROM users WHERE id = #{user_id}").each[0]['bio']

            expect(stored_bio).to eq(bio)
        end

        it 'should not store data user if already exist in database' do
            user = User.new(username, email, nil, nil, db_client)
            first_insert = user.save
            second_insert = user.save

            # id zero mean  can't insert to database, based on email
            expect(second_insert).to eq(0)
        end
    end

    describe "change data user" do
        it 'should save new data user with specific id' do
            
            user.save
            expect(user.username).to eq(username)

            user.username = 'papa'
            user.update
            stored_username = db_client.query("SELECT username FROM users WHERE id = #{user.id}").each[0]['username']
            expect(stored_username).to eq('papa')
        end
    end

end