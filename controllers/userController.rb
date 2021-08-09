class UserController
    attr_reader :db_client
    
    def initialize(db_client)
        @db_client = db_client
    end
end