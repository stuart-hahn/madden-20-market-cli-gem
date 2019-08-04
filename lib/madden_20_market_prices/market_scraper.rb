require 'pry'

class Madden20MarketPrices::MarketScraper
    
    def get_prices_page
        Nokogiri::HTML(open("https://www.muthead.com/prices/xbox-one/"))
    end

    def scrape_gainers
        self.get_prices_page.css("div.price-lists > div.price-lists__gainers > article > ul > li")
    end

    def make_gainers
        self.scrape_gainers.each do |player|
            Madden20MarketPrices::Player.new_from_prices_page(player)
        end
    end

    def scrape_losers
        self.get_prices_page.css("div.price-lists > div.price-lists__losers > article > ul > li")
    end

    def make_losers
        self.scrape_losers.each do |player|
            Madden20MarketPrices::Player.new_from_prices_page(player)
        end
    end

end