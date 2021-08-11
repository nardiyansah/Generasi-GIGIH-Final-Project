class Post
    def initialize(content, attachment=nil, db_client)
        @content = content
        @attachment = attachment
        @db_client = db_client
    end

    def save
        @db_client.query("INSERT INTO posts (content, attachment) VALUES ('#{@content}', '#{@attachment}')")
        id = @db_client.last_id
        data = @db_client.query("SELECT * FROM posts WHERE id = #{id}").each[0]
        data
    end
end