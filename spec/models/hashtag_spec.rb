require_relative '../../models/hashtag'
require_relative '../../db_connector'

RSpec.describe 'hashtag model' do
    db_client = create_db_client

    before(:each) do
        client = create_db_client
        client.query('set foreign_key_checks = 0')
        client.query('truncate hashtags')
        client.query('set foreign_key_checks = 1')
    end
    
    describe 'save hashtags' do
        it 'should should save one hashtag' do
            hashtag = ['ame']
            model = Hashtag.new(hashtag, db_client)

            stored_hashtag = model.save

            expect(stored_hashtag[0]['tag']).to eq('ame')
        end

        it 'should save two hashtag' do
            hashtag = ['ame', 'agari']
            model = Hashtag.new(hashtag, db_client)

            stored_hashtag = model.save

            expect(stored_hashtag[0]['tag']).to eq('ame')
            expect(stored_hashtag[1]['tag']).to eq('agari')
        end
    end
end