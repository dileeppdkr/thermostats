class CreateReadings < ActiveRecord::Migration[5.2]
  def change
    create_table :readings do |t|
      t.references :thermostat, index: true
      t.float :temperature
      t.float :humidity
      t.integer :battery_charge
      t.integer :sequence_number

      t.timestamps
    end
  end
end
