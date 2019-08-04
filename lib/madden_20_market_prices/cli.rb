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

            print_player(player, "gainer")

        elsif input == "2"
            puts "Here are the top 15 Market Losers:"
            puts ""
            print_losers

            puts ""
            puts "Which player would you like to know more about?"
            input = gets.strip

            player = Madden20MarketPrices::Player.find(input.to_i)

            print_player(player, "loser")

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

    def print_losers
        Madden20MarketPrices::MarketScraper.new.make_losers
        Madden20MarketPrices::Player.all.each.with_index { |player, index| puts "#{index + 1}. #{player.name}"}
    end

    def print_player(player, type)
        puts ""
        puts "---Basic Information---"
        puts "Player name: #{player.name}"
        puts "Position and item type: #{player.info}"
        puts "Overall: #{player.ovr}"
        puts ""
        puts "---Price Information---"
        puts "Current cost: #{player.cost}"
        if type == "gainer"
            puts "That's up #{player.price_change_percent} from yesterday! Sell sell sell!"
        elsif type == "loser"
            if "#{player.price_change_percent}" != "None --"
                puts "That's down #{player.price_change_percent} from yesterday. Ouch."
            else
                puts "This item is too new for accurate price change information."
            end
        end
        puts ""
    end

end