module WalletsHelper
  def show_stocks_from_wallet(wallet)
    return 'No stocks in this wallet:' if wallet.stocks.empty?

    stock_description = ''
    wallet.stocks.each do |stock|
      stock_description += "<b>#{stock.symbol}:</b>: "
      stock_description += define_price(stock)
      stock_description += '<br/>'
    end
    return sanitize(stock_description)
  end

  def define_price(stock)
    return stock.price.to_s if stock.price.present?
    '(no price)'
  end
end
