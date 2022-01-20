class CreateStocks < ActiveRecord::Migration[7.0]
  def change
    create_table :stocks do |t|
      t.string :symbol
      t.decimal :price
      t.references :wallet, null: false, foreign_key: true

      t.timestamps
    end
  end
end
