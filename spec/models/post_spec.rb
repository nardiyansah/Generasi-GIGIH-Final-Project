require_relative '../../models/post'
require_relative '../../db_connector'

RSpec.describe 'post model' do
    db_client = create_db_client
    query_insert_user = "INSERT INTO users (username, email, bio) VALUES ('foo', 'foo@mail.com', 'i am foo')"

    before(:each) do
        client = create_db_client
        client.query('set foreign_key_checks = 0')
        client.query('truncate users')
        client.query('truncate posts')
        client.query('truncate user_posts')
        client.query('truncate hashtags')
        client.query('truncate post_hashtags')
        client.query('set foreign_key_checks = 1')
    end

    describe 'create new post' do
        it 'should create a new post' do
            model = Post.new('new post', nil, db_client)
            data = model.save

            expect(data['id']).to eq(1)
            expect(data['content']).to eq('new post')
        end
    end

end