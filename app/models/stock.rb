class Stock < ApplicationRecord

  def self.new_lookup(ticker_symbol)
    client = IEX::Api::Client.new(
      publishable_token: Rails.application.credentials.iex_client[:token],
      # publishable_token: 'pk_640fb043666045cbb284550d311ebf95' ,
      secret_token: 'sk_ed98ef3591784076ad2eb5be46504d00',
      endpoint: 'https://cloud.iexapis.com/v1'
    )
    client.quote(ticker_symbol)
    # getting all the data. use latest_price
  end
end
