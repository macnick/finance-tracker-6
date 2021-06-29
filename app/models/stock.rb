class Stock < ApplicationRecord
  has_many :user_stocks
  has_many :users, through: :user_stocks

  validates :name, :ticker, presence: true


  def self.new_lookup(ticker_symbol)
    client = IEX::Api::Client.new(
      publishable_token: Rails.application.credentials.iex_client[:api_key],
      secret_token: Rails.application.credentials.iex_client[:secret_key],
      endpoint: 'https://cloud.iexapis.com/v1'
    )
    begin
      stock = client.quote(ticker_symbol)
      # getting all the data. use latest_price
      # new(ticker: stock.symbol, name: stock.company_name, last_price: stock.latest_price, week_52_high: stock.week_52_high, week_52_low: stock.week_52_low)
    rescue => exception
      nil      
    end
  end

  def self.check_db(ticker_symbol)
    where(ticker: ticker_symbol).first
  end

end
