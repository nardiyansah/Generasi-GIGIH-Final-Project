require_relative '../../models/user'

RSpec.describe User do

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
    end

end