class Post
    def initialize(content, attachment=nil)
        @content = content
        @attachment = attachment
    end

    def save
        1
    end
end