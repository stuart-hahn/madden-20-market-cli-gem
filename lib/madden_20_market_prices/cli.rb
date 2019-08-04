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
        puts ""

        if input == "1"
            puts "Here are the top 15 Market Gainers:"
            puts ""
            print_gainers

            puts ""
            puts "Which player would you like to know more about?"
            input = gets.strip

            player = Madden20MarketPrices::Player.find(input.to_i)

            print_player(player)

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

    def print_player(player)
        puts ""
        puts "---Basic Information---"
        puts "Player name: #{player.name}"
        puts "Position and item type: #{player.info}"
        puts "Overall: #{player.ovr}"
        puts ""
        puts "---Price Information---"
        puts "Current cost: #{player.cost}"
        puts "That's up #{player.gain} from yesterday! Sell sell sell!"
        puts ""
    end

end