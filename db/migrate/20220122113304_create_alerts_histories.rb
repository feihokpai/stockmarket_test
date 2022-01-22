class CreateAlertsHistories < ActiveRecord::Migration[7.0]
  def change
    create_table :alerts_histories do |t|
      t.references :user, null: false, foreign_key: true
      t.string :description, null: false      

      t.timestamps
    end
  end
end
