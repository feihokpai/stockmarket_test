class Stock < ApplicationRecord
  belongs_to :wallet

  has_one :alert, dependent: :destroy
end
