require 'ansi'
require 'money'
require 'text-table'

require_relative './pricer'
require_relative './basis'

class Reporter

  def costs
    Basis.costs
  end

  def invested_currencies
    Basis.costs.select {|cost| Basis.costs[cost]["amount"] > 0 }
  end

  def standings
    prices = Pricer.new.prices invested_currencies.keys
    standings = []

    invested_currencies.each do |currency|
      currency_ticker_symbol = currency[0]

      value  = costs[currency_ticker_symbol]["amount"] * prices[currency_ticker_symbol.to_sym]
      cost   = costs[currency_ticker_symbol]["usd_cost"]
      profit = value - cost

      standings << [
        currency_ticker_symbol,
        "#{value.symbol}#{value} #{value.currency}",
        "#{cost.symbol}#{cost} #{cost.currency}",
        "#{profit.symbol}#{profit} #{profit.currency}"
      ]
    end

    standings
  end

  def report
    # this is the text-table gem api
    table = Text::Table.new
    table.head = [
      'Name', 'Value', 'Cost', 'Profit'
    ]
    table.rows = format_currency(standings)
    table.to_s
  end

  def currency_name
    "USD"
  end


  private

  # the money gem works in cents
  def format_currency standings
    standings.collect do |cryptocurrency|
      cryptocurrency.collect {|column| Money.new(value * 100, currency_name) }
    end
  end

end
