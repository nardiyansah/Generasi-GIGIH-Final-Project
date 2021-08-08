class User
    attr_reader :username, :email, :bio, :id

    def initialize(username, email, bio=nil, id=nil)
        @username = username
        @email = email
        @bio = bio
        @id = id
    end

end