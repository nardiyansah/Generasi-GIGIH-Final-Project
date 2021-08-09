require_relative '../../models/user'
require_relative '../../db_connector'

RSpec.describe User do
    before(:each) do
        db_client = create_db_client
        db_client.query('SET FOREIGN_KEY_CHECKS = 0')
        db_client.query('TRUNCATE users')
        db_client.query('SET FOREIGN_KEY_CHECKS = 1')
    end

    describe "initialize object class" do
        before(:each) do
            @username = 'foo'
            @email = 'foo@mail.com'
    
            @user = User.new(@username, @email)
        end

        it 'should has username' do
            expect(@user.username).to eq(@username)
        end

        it 'should has email' do
            expect(@user.email).to eq(@email)
        end

        it 'bio can be nil' do
            expect(@user.bio).to be(nil)
        end

        it 'can contain bio' do
            bio = 'onegaishimasu'

            user = User.new(@username, @email, bio)

            expect(user.bio).to eq(bio)
        end

        it 'id can be nil' do
            expect(@user.id).to be(nil)
        end

        it 'can contain id' do
            bio = 'onegaishimasu'
            id = 1

            user = User.new(@username, @email, bio, id)

            expect(user.id).to eq(id)
        end
    end

    describe "create new user" do
        
        it 'should save new user account' do
            username = 'foo'
            email = 'foo@mail.com'
            db_client = create_db_client

            user = User.new(username, email, nil, nil, db_client)
            user_id = user.save

            expect(user_id).to eq(1)
        end

        it 'should store bio if registered with bio' do
            username = 'foo'
            email = 'foo@mail.com'
            bio = 'I am foo'
            db_client = create_db_client

            user = User.new(username, email, bio, nil, db_client)
            user_id = user.save

            stored_bio = db_client.query("SELECT bio FROM users WHERE id = #{user_id}").each[0]['bio']

            expect(stored_bio).to eq(bio)
        end

        it 'should not store data user if already exist in database' do
            username = 'foo'
            email = 'foo@mail.com'
            db_client = create_db_client

            user = User.new(username, email, nil, nil, db_client)
            first_insert = user.save
            second_insert = user.save

            # id zero mean  can't insert to database, based on email
            expect(second_insert).to eq(0)
        end
    end

end