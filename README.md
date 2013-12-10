# Phase Three Profit
This is a small console app that reports your standings and (hopefull) profits
depending on your cost basis.  Just fill in your cost details and it will
tell you if you've made money or not

This program is READ-ONLY.  Don't worry.  It just uses your standings for reporting.  Go ahead
and put in some BS numbers if you want and see how it works.  It's really just a spreadsheet
that can hit the web to get prices for you automatically.

![image](https://raw.github.com/squarism/phase_three_profit/master/img/report_table.png)


## Setup

### Phase One - Api Key for Price Updates
You have to sign up for an account at btc-e.com (you might already have one if you're doing bitcoin stuff).

- Generate an api key at btc-e.com under 'Profile -> API Keys'
- Set your API Key to **Info Only**
- Copy `btce-api-key.yml.example` to `btce-api-key.yml`
- Put your api key and secret into btce-api-key.yml.

Don't share this file with anyone.  Please make sure your API Key to **info only** in the btc-e.com website.  This app does not try to do any trading but I don't want you to allow more access than necessary.


### Phase Two - Fill in Your Costs
Edit basis.yml and fill in the following:

- Amount owned
- Price bought at (that means the currency price)
- The amount paid or worth at time of purchase (in USD).

Why do I need the amount paid?  Well, first of all you should know this for tax season (right?!).  Second, everything is based off BTC and there's no way for me to guess at what you paid for it at what time.

For example, with the basis.yml.example file:

    trc:
      amount:   0.00
      price:    0.00
      usd_cost: 0.00

Let's say I bought 185 TRC coins at .00217 BTC/TRC.  It cost me $20 in bitcoins to do so at that moment in time.

    trc:
      amount:   185.00
      price:    0.00217
      usd_cost: 20.00

Then save the file as basis.yml.


### Phase Three - Profit!
You need a Ruby environment up and running.  The one that comes with Mac 10.9 is probably ok but it's probably going to need a your password.  If you don't like that, install Ruby with RVM.  If you don't know what all this means, sorry.  Deploying ruby apps kind of sucks.  I'm looking at alternatives.

    $ bundle
    $ rake report

![image](https://raw.github.com/squarism/phase_three_profit/master/img/underpants.png)

## Paranoia
Maybe you want to hide your totals (for example, the screenshot above).

    $ rake test_mode

## TODO
- Turn into a long running process like top.