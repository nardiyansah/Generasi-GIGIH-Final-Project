require_relative '../models/user'

class UserController
    attr_reader :db_client

    def initialize(db_client)
        @db_client = db_client
    end

    def create(data)
        if data.nil?
            return 400
        end
        
        if data['username'].nil? or data['username'].empty? or data['email'].nil? or data['email'].empty?
            return 400
        end

        username = data['username']
        email = data['email']
        bio = data['bio']
        
        model = User.new(username, email, bio, nil, @db_client)
        code = model.save

        if code == 0
            return 406
        end
        201
    end
end