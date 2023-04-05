class AddCabinets < ActiveRecord::Migration[6.1]
  def change
    create_table :cabinets do |t|
      t.string :name, null: false
      t.integer :floor, null: false, default: 0
      t.timestamps null: false
    end

    add_reference :users, :cabinet
  end
end
