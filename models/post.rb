class Post
    def initialize(content, attachment=nil, user_id, db_client)
        @content = content
        @attachment = attachment
        @user_id = user_id
        @db_client = db_client
    end

    def save
        @db_client.query("INSERT INTO posts (content, attachment, user_id) VALUES (\"#{@db_client.escape(@content)}\", \"#{@attachment}\", #{@user_id})")
        id = @db_client.last_id
        data = @db_client.query("SELECT * FROM posts WHERE id = #{id}").each[0]
        data
    end
end