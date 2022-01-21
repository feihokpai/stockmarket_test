class Stock < ApplicationRecord
  belongs_to :wallet

  has_many :alerts, dependent: :destroy
end
