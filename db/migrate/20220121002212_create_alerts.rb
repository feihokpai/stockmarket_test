class CreateAlerts < ActiveRecord::Migration[7.0]
  def change
    create_table :alerts do |t|
      t.decimal :minimum_price, precision: 8, scale: 2
      t.decimal :maximum_price, precision: 8, scale: 2
      t.references :stock, null: false, foreign_key: true

      t.timestamps
    end
  end
end
