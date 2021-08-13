class Hashtag
    def initialize(hashtags, db_client)
        @hashtags = hashtags
        @db_client = db_client
    end

    def save
        unless @hashtags.nil?
            if @hashtags.empty?
                return []
            end
            data = []
            uniq_hashtags = @hashtags.map(&:downcase).uniq
            uniq_hashtags.each do |tag|
                unless tag.empty?
                    tag_lowercase = tag.downcase.delete(" \t\r\n")
                    @db_client.query("insert into hashtags (tag, amount) values ('#{tag_lowercase}', 1) on duplicate key update amount = values(amount) + 1")
                    temp = @db_client.query("select * from hashtags where tag = '#{tag_lowercase}'").each[0]
                    data.append(temp)
                end
            end
            return data
        end
        return []
    end
end