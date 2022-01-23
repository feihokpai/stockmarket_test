require "rails_helper"

RSpec.describe Stock, type: :model do
  let(:user_let) { User.create(email: 'fabiano@gmail.com', name: 'Fabiano', password: '123456') }
  let(:wallet_let) { Wallet.create(name: 'Super Wallet', user: user_let) }
  let(:stock_let) { Stock.create(symbol: 'AAPL', price: 25.00, wallet: wallet_let) }
  let(:alert_let) { Alert.create(stock: stock_let, minimum_price: 20.00, maximum_price: 40.00, active: true) }

  context 'validations' do
    it 'Shouldn\'t allow to save a stock without symbol' do
      Stock.create!(symbol: nil, price: 20.00, wallet: wallet_let)
      fail 'The stock shouldnt be created'
    rescue ActiveRecord::NotNullViolation
      # If reach here, passed
    end

    it 'Shouldn\'t allow to save a stock without a wallet' do
      Stock.create!(symbol: 'OIOI', price: 20.00, wallet: nil)
      fail 'The stock shouldnt be created'
    rescue ActiveRecord::RecordInvalid
      # If reach here, passed
    end
  end

  context 'About to call the alert' do
    it 'If the price changes, and the stock has an alert, invoke the alert verification' do
      alert_let #Invoking to instanciate all let values.
      expect(stock_let.alert).to receive(:verify_alert)
      stock_let.update!({price: 21.00})
    end    
  end
end