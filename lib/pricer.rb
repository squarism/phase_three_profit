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

    # nvc = Btce::Ticker.new "nvc_btc" if ticker_code_included?("nvc", tickers)
    # ppc = Btce::Ticker.new "ppc_btc" if ticker_code_included?("ppc", tickers)
    # trc = Btce::Ticker.new "trc_btc" if ticker_code_included?("trc", tickers)
    # xpm = Btce::Ticker.new "xpm_btc" if ticker_code_included?("xpm", tickers)


    # return hash of ticker values in opinionated formats
    # {
    #   btc: btc_in_usd,
    #   ftc: ftc.last * btc_in_usd,
    #   ltc: ltc.last * btc_in_usd,
    #   nmc: nmc.last * btc_in_usd,
    #   nvc: nvc.last * btc_in_usd,
    #   ppc: ppc.last * btc_in_usd,
    #   trc: trc.last * btc_in_usd,
    #   xpm: xpm.last * btc_in_usd
    # }
    ticker_values
  end


  private

  # TODO: mutating a hash in place = BAD NEWS.  So much for functional programming.
  def add_ticker_value(ticker, ticker_values)
    if ticker == "btc"
      ticker_values[:btc] = @btc_in_usd
    else
      market_price = Btce::Ticker.new "#{ticker}_btc"
      ticker_values[ticker.to_sym] = market_price.last * @btc_in_usd
    end
  end

  # TODO: remove?
  def all_tickers
    %w[ btc ftc ltc nmc nvc ppc trc xpm ]
  end

end
