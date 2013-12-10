require 'money'
I18n.enforce_available_locales = false  # for the money gem


class Currency
  attr_accessor :name, :value, :cost, :profit, :last_price

  def self.currency_name
    "USD"  # or "EUR" or whatever three letter code you want
  end

  def initialize(name, value, cost, last_price)
    self.name       = name
    self.value      = value
    self.cost       = cost
    self.last_price = last_price
  end

  # def standing
  #   [ self.name, self.value, self.cost, self.profit ]
  # end

  # I failed at getting colors AND text tables to work
  def formatted_standing
    [ name, value, cost, profit ]
  end

  def profit
    self.value - self.cost
  end

  # the money gem works in cents
  def self.format number
    m = Money.new(number * 100, self.currency_name)
    separator_formatted = m.to_s.reverse.scan(/(?:\d*\.)?\d{1,3}-?/).join(',').reverse
    "#{m.symbol} #{separator_formatted}"
  end

end
