require_relative '../models/user'

class UserController
    attr_reader :db_client

    def initialize(db_client)
        @db_client = db_client
    end

    def create(data)
        if data.nil?
            return [ 400, 'missing data. please sure you already give username and email' ]
        end

        if data['username'].nil? or data['username'].empty? or data['email'].nil? or data['email'].empty?
            return [ 400, 'missing data. please sure you already give username and email' ]
        end

        username = data['username']
        email = data['email']
        bio = nil
        
        model = User.new(username, email, bio, nil, @db_client)
        created_id = model.save

        if created_id == 0
            return [ 406, "can't save data, maybe the data is already exist" ]
        end
        [ 201, {message: "new account is created", id: created_id }.to_json]
    end

    def update(id, data)
        username = data['username']
        bio = data['bio']

        model = User.new(username, nil, bio, id, @db_client)
        id = model.update

        if id < 1
            return [404, "user not found"]
        end
        [200, {
            message: "data has been updated",
            username: username,
            bio: bio
    }.to_json]
    end
end