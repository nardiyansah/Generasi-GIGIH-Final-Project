class Hashtag
    def initialize(hashtags, db_client)
        @hashtags = hashtags
        @db_client = db_client
    end

    def save
        if @hashtags.empty?
            return 0
        end
        data = []
        @hashtags.each do |tag|
            unless tag.empty?
                tag_lowercase = tag.downcase
                @db_client.query("insert into hashtags (tag, amount) values ('#{tag_lowercase}', 1) on duplicate key update amount = values(amount) + 1")
                temp = @db_client.query("select * from hashtags where tag = '#{tag_lowercase}'").each[0]
                data.append(temp)
            end
        end
        data
    end
end