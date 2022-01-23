require 'rails_helper'

RSpec.describe MarketStackApi do
  let(:api) { MarketStackApi.new }
  let(:fake_response_with_result) do
    { data: [{ last: 34.21 }] }.to_json
  end
  let(:fake_response_without_result) do
    { 'error' => { 'code' => 'no_valid_symbols_provided',
                   'message' => 'At least one valid symbol must be provided' } }.to_json
  end
  let(:fake_response_with_many_results) do
    { data: [
      { last: nil },
      { last: nil },
      { last: 56.31 },
      { last: 34.21 },
      { last: 11.70 }
    ]}.to_json
  end

  def request_for_microsoft(fake_request: false)
    api.last_price_of('MSFT', fake_request:)
  end

  def request_should_return_some_price
    allow(Net::HTTP).to receive(:get).and_return(fake_response_with_result)
  end

  context 'fake_request parameter' do
    before do
      request_should_return_some_price
    end

    it 'If fake_request is true, never invoke API' do
      expect(Net::HTTP).to_not receive(:get)
      request_for_microsoft(fake_request: true)
    end

    it 'If fake_request is false, invoke API' do
      expect(Net::HTTP).to receive(:get)
      request_for_microsoft
    end
  end

  context 'About symbols to exist or not' do
    it 'If the symbol is not found by API, returns nil' do
      allow(Net::HTTP).to receive(:get).and_return(fake_response_without_result)
      response = request_for_microsoft
      expect(response).to be_nil
    end

    it 'If the symbol exists and the API found some results, return the value as a Float number' do
      request_should_return_some_price
      response = request_for_microsoft
      expect(response).to eq(34.21)
    end

    it 'If the symbol exists and the API brought many results, return the first with field \'last\' not nil' do
      allow(Net::HTTP).to receive(:get).and_return(fake_response_with_many_results)
      response = request_for_microsoft
      expect(response).to eq(56.31)
    end
  end
end
