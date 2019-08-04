class Madden20MarketPrices::Player

    attr_accessor :name, :info, :cost, :gain, :ovr

    @@all = []

    def initialize(name = nil, info = nil, cost = nil, gain = nil, ovr = nil)
        @name = name
        @info = info
        @cost = cost
        @gain = gain
        @ovr = ovr
        @@all << self
    end

    def self.new_from_prices_page(player)
        self.new(
            player.css("div.list-info-player__player-name").text.strip,
            player.css("div.list-info-player__player-info").text.strip,
            player.css("div.cost-summary__price").text.strip,
            player.css("div.cost-summary__effect--gain").text.strip,
            player.css("span.list-info-player__ovr-value").text.strip
        )
    end

    def self.all
        @@all
    end

    def self.find(index)
        self.all[index - 1]
    end

end