class User
    attr_reader :username, :email

    def initialize(username, email)
        @username = username
        @email = email
    end

end