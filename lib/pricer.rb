require 'btce'

class Pricer

  # TODO: this abstraction may be overly simple
  def prices(tickers=[])
    tickers = all_tickers if tickers == []
    ticker_values = {}

    # cache this value since all currencies are based around BTC
    btc = Btce::Ticker.new "btc_usd"
    @btc_in_usd = btc.last

    # loop through all the ticker symbols that the user has invested and get the
    # prices for those tickers only, no need to get prices on things we don't care about
    tickers.each do |ticker|
      add_ticker_value(ticker, ticker_values)
    end

    ticker_values
  end


  private

  # TODO: mutating a hash in place = BAD NEWS.  So much for functional programming.
  def add_ticker_value(ticker, ticker_values)
    if ticker == "btc"
      ticker_values[:btc] = @btc_in_usd
    else
      begin
        market_price = Btce::Ticker.new "#{ticker}_btc"
        ticker_values[ticker.to_sym] = market_price.last * @btc_in_usd
      rescue Exception => e
        # TODO: find a way to capture bad json parsing thrown by library.
        puts e.message
      end
    end
  end

  # TODO: remove?
  def all_tickers
    %w[ btc ftc ltc nmc nvc ppc trc xpm ]
  end

end
