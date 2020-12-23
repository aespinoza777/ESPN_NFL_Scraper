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
    puts "Welcome to the ESPN Scraper, your source for all the latest news for the MLB, NFL, NHL, and NBA!".colorize(:blue)
    options = ["MLB", "NBA", "NFL", "NHL", "Exit"]
    input = @prompt.select("Select the sport you'd like to read about...", options).downcase
    if input == "exit"
      puts "Ending the program. See you again soon!".colorize(:yellow)
      exit
    else
      @sport = input
      list_teams
    end
  end

  def list_teams
    system "clear"
    case self.sport
    when "mlb"
      all_teams = Teams.mlb_teams
    when "nba"
      all_teams = Teams.nba_teams
    when "nfl"
      all_teams = Teams.nfl_teams
    when "nhl"
      all_teams = Teams.nhl_teams
    end
    all_teams.each do |division, teams|
      puts division.to_s.sub(/_/, ' ').upcase.colorize(:magenta).bold
      teams.each do |team|
        team.each{|key,value| puts "  #{key.to_s.upcase} - #{value}"}
      end
    end
    menu
  end

  def menu
    options = Teams.team_abbreviations(self.sport).collect{|team| team.upcase} + ["Select New Sport", "Exit"]
    input = @prompt.select("Select the team you'd like to read about.", options, filter: true).downcase
    if Teams.team_abbreviations(self.sport).include?(input)
      @team = input
      build_url
      self.sport == "nhl" ? Scraper.scrape_new_nhl_articles(self.url) : Scraper.scrape_new_articles(self.url)
      display_articles
    elsif input == "select new sport"
      Article.destroy_all
      run
    elsif input ==  "exit"
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
    options = ["1", "2", "3", "4", "5",
    "Select New Sport", "Select New Team", "Exit"]
    input = @prompt.select("Which article would you like to read?", options)
    if input.to_i.between?(1, 5)
      article_index = input.to_i - 1
      @article = Article.all[article_index]
      show_article_content
      exit_menu
    elsif input == "Select New Sport"
      Article.destroy_all
      run
    elsif input == "Select New Team"
      Article.destroy_all
      list_teams
      menu
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
    elsif input == "Select a new sport"
      Article.destroy_all
      run
    elsif input == "Select a new team in this league"
      list_teams
    elsif input == "Exit"
      puts "Ending the program. See you again soon!".colorize(:yellow)
      exit
    end
  end

  private
    def build_url
      @url = "https://www.espn.com/" + "#{@sport}" + "/team/_/name/" + "#{@team}"
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
