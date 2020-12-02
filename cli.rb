# CLI Controller
class CLI
    attr_accessor :sport, :team, :url, :article
  
    def initialize
      @prompt = TTY::Prompt.new
    end
  
    def run
      welcome
    end
  
    def welcome
      system "clear"
      puts "Welcome to the ESPN NFL Scraper, your source for all the latest news for the NFL!".colorize(:yellow)
      options = ["Continue", "Exit"]
      input = @prompt.select("Select continue, to continue, or exit to leave.", options).downcase
      if input == "exit"
        puts "Ending the program. See you again soon!".colorize(:yellow)
        exit
      else
        nfl_menu
      end
    end
  
    def nfl_menu
        build_url
        Scraper.scrape_new_nfl_articles(self.url)  
        display_articles
      if input == "exit"
        puts "Ending the program. See you again soon!".colorize(:yellow)
        exit
      end
    end
  
    def display_articles
      system "clear"
      Article.all.slice(0,5).each_with_index do |article, index|
        puts "#{index + 1}. #{article.title}".colorize(:light_blue).bold
        puts "  #{article.description} \n \n"
      end
      article_menu
    end
  
    def article_menu
      options = ["1", "2", "3", "4", "5","Exit"]
      input = @prompt.select("Which article would you like to read?", options)
      if input.to_i.between?(1, 5)
        article_index = input.to_i - 1
        @article = Article.all[article_index]
        show_article_content
        exit_menu
      elsif input == "Exit"
        puts "Ending the program. See you again soon!".colorize(:yellow)
        exit
      end
    end
  
    def show_article_content
      system "clear"
      Scraper.get_content(self.article)
      puts "#{self.article.title} \n \n".colorize(:light_blue).bold
      if self.article.content.size > 0
        self.article.content.each {|p| puts "#{p.text} \n \n"}
      else
        puts "This is a link to an ESPN Radio report. To listen to the report vist: #{self.article.url}".colorize(:red)
      end
    end
  
    def exit_menu
      options = ["Return to articles", "Select a new sport", "Select a new team in this league", "Exit"]
      input = @prompt.select("What would you like to do now?", options)
      if input == "Return to articles"
        display_articles
        article_menu
      elsif input == "Exit"
        puts "Ending the program. See you again soon!".colorize(:yellow)
        exit
      end
    end
  
    private
      def build_url
        @url = "https://www.espn.com/nfl/"
      end
  end