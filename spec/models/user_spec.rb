require_relative '../../models/user'

RSpec.describe User do

    describe "initialize object class" do
        it 'should has username' do
            username = 'foo'
            user = User.new(username)

            expect(user.username).to eq(username)
        end
    end

end