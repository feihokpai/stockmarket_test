require 'net/http'
require 'json'

class MarketStackApi
  DATE_FORMAT = '%Y-%m-%d'

  def initialize; end

  def last_price_of(symbol, fake_request: false)
    @fake_request = fake_request
    api_response = invoke_api(symbol)
    return nil if api_response['data'].blank?
    
    stock_hashs_array = api_response['data']
    stock_data = stock_hashs_array.find { |hash| hash['last'].present? }
    stock_data&.dig('last')
  end

  private

  def invoke_api(symbol)
    return mount_fake_response if @fake_request

    uri = URI(complete_url)
    uri.query = URI.encode_www_form(define_params(symbol))
    json = Net::HTTP.get(uri)
    JSON.parse(json)
  end

  def mount_fake_response
    response = {}
    response['data'] = []
    stock_data = {}
    stock_data['last'] = rand(1..100).to_f
    response['data'] << stock_data
    response
  end

  def complete_url
    base_url + intraday_url
  end

  def intraday_url
    last_field = 'latest'
    today = Date.today
    if today.saturday?
      last_field = today.yesterday.strftime(DATE_FORMAT)
    elsif today.sunday?
      last_field = today.yesterday.yesterday.strftime(DATE_FORMAT)
    end

    "/v1/intraday/#{last_field}"
  end

  def base_url
    'http://api.marketstack.com'
  end

  def define_params(symbol)
    {
      access_key: 'dce2c710deaa8ff84be1b04a1916ff79',
      symbols: symbol
    }
  end
end
