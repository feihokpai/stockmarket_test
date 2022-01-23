class Stock < ApplicationRecord
  belongs_to :wallet
  has_one :alert, dependent: :destroy

  after_update :verify_alert

  private

  def verify_alert
    alert&.verify_alert
  end
end
