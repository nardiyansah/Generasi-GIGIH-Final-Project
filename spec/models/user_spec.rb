require_relative '../../models/user'

RSpec.describe User do

    describe "initialize object class" do
        it 'should has username' do
            username = 'foo'
            email = 'foo@mail.com'

            user = User.new(username, email)

            expect(user.username).to eq(username)
        end

        it 'should has email' do
            username = 'foo'
            email = 'foo@mail.com'

            user = User.new(username, email)

            expect(user.email).to eq(email)
        end

        it 'bio can be nil' do
            username = 'foo'
            email = 'foo@mail.com'

            user = User.new(username, email)

            expect(user.bio).to be(nil)
        end
    end

end