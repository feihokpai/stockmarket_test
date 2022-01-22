class Stock < ApplicationRecord
  belongs_to :wallet
  has_one :alert, dependent: :destroy

  after_save :verify_alert

  private

  def verify_alert
    alert&.verify_alert
  end
end
