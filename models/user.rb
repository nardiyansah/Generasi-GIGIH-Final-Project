class User
    attr_reader :username, :email, :bio, :id

    def initialize(username, email, bio=nil, id=nil, db_client=nil)
        @username = username
        @email = email
        @bio = bio
        @id = id
        @db_client = db_client
    end

    def save
        begin
            @db_client.query("INSERT INTO users (username, email, bio) VALUES ('#{username}', '#{email}', '#{bio}')")
            @id = @db_client.last_id
        rescue => exception
            @id = 0
        end
        @id
    end

end