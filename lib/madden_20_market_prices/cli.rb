class Madden20MarketPrices::CLI

    def call
        puts ""
        puts "Welcome to Muthead's Prices Tool."
        puts ""
        puts "What type of information are you looking for?"
        list_choices
    end

    def list_choices
        puts <<~DOC

        1. Market Gainers
        2. Market Losers
        3. Cheapest Training
        4. Most Expensive Players
        5. Daily Snipes

      DOC

      make_choice
    end

    def make_choice
        puts "Select a number:"
        input = gets.strip.downcase
        if input == "1"
            puts ""
            puts "Here are the top 15 Market Gainers:"
            puts ""
            print_gainers
        elsif input == "2"
            puts "You chose Market Losers. Let's scrape the page!"
        elsif input == "exit"
            puts "Womp womp."
        else
            puts "You must choose a number or type 'exit'."
            make_choice
        end
    end

    def print_gainers
        Madden20MarketPrices::MarketScraper.new.make_gainers
        Madden20MarketPrices::Player.all.each.with_index { |player, index| puts "#{index + 1}. #{player.name}"}
    end

end