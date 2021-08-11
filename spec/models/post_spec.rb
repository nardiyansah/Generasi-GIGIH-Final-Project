require_relative '../../models/post'
require_relative '../../db_connector'

RSpec.describe 'post model' do
    db_client = create_db_client
    query_insert_user = "INSERT INTO users (username, email, bio) VALUES ('foo', 'foo@mail.com', 'i am foo')"

    before(:each) do
        db_client.query('SET FOREIGN_KEY_CHECKS = 0')
        db_client.query('TRUNCATE users')
        db_client.query('TRUNCATE posts')
        db_client.query('TRUNCATE user_posts')
        db_client.query('TRUNCATE hashtags')
        db_client.query('TRUNCATE post_hashtags')
        db_client.query('SET FOREIGN_KEY_CHECKS = 1')
    end

    describe 'create new post' do
        it 'should create a new post' do
            model = Post.new('new post')
            post_id = model.save

            expect(post_id).to eq(1)
        end
    end

end