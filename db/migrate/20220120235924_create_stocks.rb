class CreateStocks < ActiveRecord::Migration[7.0]
  def change
    create_table :stocks do |t|
      t.string :symbol, null: false
      t.decimal :price, precision: 8, scale: 2
      t.references :wallet, null: false, foreign_key: true

      t.timestamps
    end
  end
end
