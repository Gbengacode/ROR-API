class ArticlesRepresenter
    def initialize(articles)
        @articles = articles
    end

    def as_json
        articles.map do |article|
            {
                id: article.id,
                title: article.title,
                body: article.body,
                authorname: "#{article.author.firstname} #{article.author.lastname}"
            }
        end
    end
    attr_reader :articles
end