class AddReferenceToUserInWallet < ActiveRecord::Migration[7.0]
  def change
    add_reference :wallets, :user, foreign_key: true, null: false
  end
end
