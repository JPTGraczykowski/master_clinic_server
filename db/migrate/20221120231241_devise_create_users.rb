# frozen_string_literal: true

class DeviseCreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :email, null: false
      t.string :encrypted_password, null: false
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :telephone
      t.integer :role, default: 0
      t.boolean :active, default: true
      t.timestamps null: false
    end

    add_index :users, :email, unique: true
  end
end
