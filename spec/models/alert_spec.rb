require "rails_helper"

RSpec.describe Stock, type: :model do
  let(:user_let) { User.create(email: 'fabiano@gmail.com', name: 'Fabiano', password: '123456') }
  let(:wallet_let) { Wallet.create(name: 'Super Wallet', user: user_let) }
  let(:stock_let) { Stock.create(symbol: 'AAPL', price: 25.00, wallet: wallet_let) }
  let(:alert_let) { Alert.create(stock: stock_let, minimum_price: 20.00, maximum_price: 40.00, active: true) }

  context 'field active' do
    it 'If the verify_alert is invoked and alert is inactive do nothing' do
      expect(alert_let).to_not receive(:verify_maximum_price)
      expect(alert_let).to_not receive(:verify_minimum_price)
      alert_let.active = false
      alert_let.verify_alert
    end

    it 'If the verify_alert is invoked and alert is active verify minimum and maximum prices' do
      expect(alert_let).to receive(:verify_maximum_price)
      expect(alert_let).to receive(:verify_minimum_price)
      alert_let.verify_alert
    end
  end

  context 'Stock price undefined' do
    it 'If the stock price is nil dont verify prices' do
      shouldnt_verify_prices_if_stock_price_is(nil)
    end

    def shouldnt_verify_prices_if_stock_price_is(value)
      expect(alert_let).to_not receive(:verify_maximum_price)
      expect(alert_let).to_not receive(:verify_minimum_price)
      alert_let.stock.price = value
      alert_let.verify_alert
    end

    it 'If the stock price is blank dont verify prices' do
      shouldnt_verify_prices_if_stock_price_is("")
    end

    it 'If the stock price is zero dont verify prices' do
      shouldnt_verify_prices_if_stock_price_is(0)
      shouldnt_verify_prices_if_stock_price_is(0.0)
    end
  end

  context 'Creation of AlertsHistory rows' do
    before do
      AlertsHistory.delete_all
    end

    context 'Shouldnt create' do
      after do        
        expect(AlertsHistory.count).to be_zero
        expect(alert_let.active).to be_truthy
      end

      it 'If the stock price is not out of limits dont create an AlertHistory' do            
        # It's expected in the initializers from this class the value is not out of the limits
        alert_let.verify_alert   
      end
  
      it 'If the stock price is equals to the minimum alert price dont create an AlertHistory' do
        stock_let.price = alert_let.minimum_price
        alert_let.verify_alert   
      end
  
      it 'If the stock price is equals to the maximum alert price dont create an AlertHistory' do
        stock_let.price = alert_let.maximum_price
        alert_let.verify_alert   
      end
    end

    context 'Should create' do
      after do
        expect(AlertsHistory.count).to eq(1)
        expect(alert_let.active).to be_falsy
      end

      it 'If the stock price is lower than the minimum price create an AlertsHistory' do      
        stock_let.price = alert_let.minimum_price - 0.01
        alert_let.verify_alert
        expect(AlertsHistory.count).to eq(1)
      end

      it 'If the stock price is greater than the maximum price create an AlertsHistory' do      
        stock_let.price = alert_let.maximum_price + 0.01
        alert_let.verify_alert
        expect(AlertsHistory.count).to eq(1)
      end
    end    
  end
  
end