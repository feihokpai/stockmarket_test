class Alert < ApplicationRecord
  belongs_to :stock

  delegate :wallet, to: :stock
  delegate :user, to: :wallet

  DATE_TIME_FORMAT = '%Y-%m-%d %H:%M:%S'

  def verify_alert
    return unless active
    return if stock.price.blank?

    verify_minimum_price
    verify_maximum_price
  end

  private

  def verify_minimum_price
    return if minimum_price.blank?

    if stock.price < minimum_price
      message = "Stock: #{stock.symbol}- Minimum reached. Price: #{stock.price} - target: #{minimum_price}"
      create_alert_history(message)
    end
  end

  def create_alert_history(message)
    description = "#{define_timestamp}: #{message}"
    ActiveRecord::Base.transaction do
      AlertsHistory.create!({ description:, user: })
      update!({ active: false })
    end
  end

  def define_timestamp
    Time.current.strftime('%Y-%m-%d %H:%M:%S')
  end

  def verify_maximum_price
    return if maximum_price.blank?

    if stock.price > maximum_price
      message = "Maximum reached. Price: #{stock.price} - target: #{maximum_price}"
      create_alert_history(message)
    end
  end
end
