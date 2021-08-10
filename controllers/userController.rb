require_relative '../models/user'

class UserController
    attr_reader :db_client

    def initialize(db_client)
        @db_client = db_client
    end

    def create(data)
        if data.nil?
            return [ 400, 'missing data' ]
        end

        if data['username'].nil? or data['username'].empty? or data['email'].nil? or data['email'].empty?
            return [ 400, 'missing data' ]
        end

        username = data['username']
        email = data['email']
        bio = nil
        
        model = User.new(username, email, bio, nil, @db_client)
        created_id = model.save

        if created_id == 0
            return [ 406, "can't save data" ]
        end
        [ 201, {message: "new account is created", id: created_id }.to_json]
    end

    def update(id, data)
        username = data['username']
        email = data['email']
        bio = data['bio']

        model = User.new(username, email, bio, id, @db_client)
        code = model.update

        if code < 1
            return [404, "user not found"]
        end
        [200, "user detail has been updated"]
    end
end