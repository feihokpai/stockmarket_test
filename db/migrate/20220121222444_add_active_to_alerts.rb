class AddActiveToAlerts < ActiveRecord::Migration[7.0]
  def change
    add_column :alerts, :active, :boolean, null: false, default: true
  end
end
