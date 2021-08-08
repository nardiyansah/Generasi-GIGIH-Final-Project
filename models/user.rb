class User
    attr_reader :username, :email, :bio

    def initialize(username, email, bio=nil)
        @username = username
        @email = email
        @bio = bio
    end

end