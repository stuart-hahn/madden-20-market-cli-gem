class Madden20MarketPrices::CLI

    # Greet user with a welcome message.

    def call
        puts "\nWelcome to Muthead's Prices Tool."
        puts ""
        puts "What type of information are you looking for?"
        list_choices
    end

    # Provide some initial direction.

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

    # Ask user for input and scrape Muthead for relevant data.

    def make_choice
        puts "Select a number:"
        input = gets.strip.downcase
        puts ""

        if input == "1"
            puts "Here are the top 15 Market Gainers:\n"
            print_gainers
            which_player

            print_player(@player, "gainer")

        elsif input == "2"
            puts "Here are the top 15 Market Losers:\n"
            print_losers
            which_player

            print_player(@player, "loser")

        elsif input == "3"
            puts "These are the players with the best Training Points/Coins Ratio:\n"
            print_trainers
            which_player

            print_player(@player, "training")

        elsif input == "4"
            puts "These are the Most Expensive Players currently on the Auction House:\n"
            print_expensive
            which_player

            print_player(@player, "expensive")

        elsif input == "5"
            puts "Recent Auction House Snipes:\n"
            print_snipes
            which_player

            print_player(@player, "snipe")

        elsif input == "exit"
            puts "Womp womp."
        else
            puts "You must choose a number or type 'exit'."
            make_choice
        end
    end

    # Print a numbered list of names

    def print
        Madden20MarketPrices::Player.all.each.with_index { |player, index| puts "#{index + 1}. #{player.name}"}
    end

    # Use the MarketScraper class to scrape Muthead and create Player objects.

    def print_gainers
        Madden20MarketPrices::MarketScraper.new.make_gainers
        print
    end

    def print_losers
        Madden20MarketPrices::MarketScraper.new.make_losers
        print
    end

    def print_trainers
        Madden20MarketPrices::MarketScraper.new.make_trainers
        print
    end

    def print_expensive
        Madden20MarketPrices::MarketScraper.new.make_expensive
        print
    end

    def print_snipes
        Madden20MarketPrices::MarketScraper.new.make_snipes
        print
    end

    def print_player(player, type)
        basic_info
        if type == "gainer"
            price_info
            puts "That's up #{player.price_change_percent} from yesterday! Sell sell sell!"
        elsif type == "loser"
            price_info
            if "#{player.price_change_percent}" != "None --"
                puts "That's down #{player.price_change_percent} from yesterday. Ouch."
            else
                puts "This item is too new for accurate price change information."
            end
        elsif type == "training"
            price_info
            puts "Whoa! This item only costs #{player.price_change_percent} coins per Training Point! Quicksell immediately."
        elsif type == "expensive"
            price_info
            if "#{player.price_change_percent}" != "--"
                puts "That's a #{player.price_change_percent} change in price from yesterday."
            else
                puts "This item is too new for accurate price change information."
            end
        elsif type == "snipe"
            puts "Somebody sniped this item for #{player.cost} coins! Are you kidding me?!"
        end
        puts ""
        continue
    end

    def which_player
        puts "\nWhich player would you like to know more about?"
        input = gets.strip

        if input.to_i.between?(1, Madden20MarketPrices::Player.all.length)
            @player = Madden20MarketPrices::Player.find(input.to_i)
        else
            puts "You must type the number that corresponds with your selection."
            which_player
        end
    end

    def basic_info
        puts "\n---Basic Information---"
        puts "Player name: #{@player.name}"
        puts "Position and item type: #{@player.info}"
        puts "Overall: #{@player.ovr}\n"
    end

    def price_info
        puts "---Price Information---"
        puts "Current cost: #{@player.cost}"
    end

    def continue
        puts "Would you like to view more players? Please type 'yes' or 'no'."
        input = gets.strip
        if input.downcase == "y" || input.downcase == "yes"
            Madden20MarketPrices::Player.reset!
            list_choices
        elsif input.downcase == "n" || input.downcase == "no"
            puts "See you later!"
        else
            puts "\nYou must type 'yes' to see more players or type 'no' to exit."
            continue
        end
    end

end