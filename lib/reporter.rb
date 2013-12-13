require 'text-table'

require_relative './pricer'
require_relative './basis'
require_relative './currency'

class Reporter

  def initialize(test_mode=false)
    @multiplier = 1         if !test_mode
    @multiplier = rand(123456) if test_mode
  end

  def costs
    Basis.costs
  end

  def invested_currencies
    Basis.costs.select {|cost| Basis.costs[cost]["amount"] > 0 }
  end

  def standings
    prices = Pricer.new.prices invested_currencies.keys

    # change this to an array of hashes
    standings = []

    invested_currencies.each do |hash|
      currency_ticker_symbol = hash[0]
      last_price = prices[currency_ticker_symbol.to_sym]

      value = costs[currency_ticker_symbol]["amount"] * last_price
      cost  = costs[currency_ticker_symbol]["usd_cost"]
      c = Currency.new(currency_ticker_symbol, value, cost, last_price)

      standings << c
    end

    standings
  end

  def report
    data = []
    standings.each do |s|
      data << [
        s.name.upcase,
        Currency.format(s.last_price),
        Currency.format(s.value * @multiplier ),
        Currency.format(s.cost * @multiplier ),
        Currency.format(s.profit * @multiplier )
      ]
    end

    data << total(standings)

    table = Text::Table.new
    table.head = [ 'Name', 'Last Price', 'Value', 'Cost', 'Profit' ]
    table.rows = data
    table.to_s
  end

  def total(standings)
    total_value  = Currency.format( standings.reduce(0) {|sum, o| sum += o.value }  * @multiplier )
    total_cost   = Currency.format( standings.reduce(0) {|sum, o| sum += o.cost }   * @multiplier )
    total_profit = Currency.format( standings.reduce(0) {|sum, o| sum += o.profit } * @multiplier )
    [ "Total", "---", total_value, total_cost, total_profit ]
  end

end
