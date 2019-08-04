class Madden20MarketPrices::Player

    attr_accessor :name

    @@all = []

    def initialize(name = nil)
        @name = name
        @@all << self
    end

    def self.new_from_prices_page(player)
        self.new(
            player.css("div.list-info-player__player-name").text.strip
        )
    end

    def self.all
        @@all
    end

end