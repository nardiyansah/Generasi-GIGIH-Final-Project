require_relative '../models/user'

class UserController
    attr_reader :db_client

    def initialize(db_client)
        @db_client = db_client
    end

    def create(data)
        if data['username'].nil? or data['username'].empty? or data['email'].nil? or data['email'].empty?
            return "username or email not correct"
        end

        username = data['username']
        email = data['email']
        bio = data['bio']
        
        model = User.new(username, email, bio, nil, @db_client)
        model.save
    end
end