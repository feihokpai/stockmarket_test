module WalletsHelper
  def show_stocks_from_wallet(wallet)
    return 'No stocks in this wallet:' if wallet.stocks.empty?

    stock_description = '<ul>'
    wallet.stocks.each do |stock|   
      stock_description += '<li>'
      stock_description += "<b>#{stock.symbol}:</b>: "
      stock_description += define_price(stock)
      stock_description += generate_links(stock)
      stock_description += '</li>'
    end
    stock_description += '</ul>'
    return sanitize(stock_description)
  end

  def define_price(stock)
    return stock.price.to_s if stock.price.present?
    '(no price)'
  end

  def generate_links(stock)
    html = "  ("    
    html += create_alert_link(stock)
    html += ")"
    sanitize(html)
  end

  def create_alert_link(stock)
    return link_to("Alerts", path_to_alert(stock))
  end

  def path_to_alert(stock)
    return edit_alert_path(stock.alert.id, wallet_id: stock.wallet_id) if stock.alert.present?
    new_alert_path({wallet_id: stock.wallet_id, stock_id: stock.id})
  end
end
