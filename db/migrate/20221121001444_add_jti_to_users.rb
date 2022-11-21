class AddJtiToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :jti, :string
    migrate_existing_users!
    change_column_null :users, :jti, false
    add_index :users, :jti, unique: true
  end

  def migrate_existing_users!
    User.find_each { |user| user.update_column(:jti, SecureRandom.uuid) }
  end
end
