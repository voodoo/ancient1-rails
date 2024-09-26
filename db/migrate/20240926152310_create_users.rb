class CreateUsers < ActiveRecord::Migration[7.2]
  def change
    create_table :users do |t|
      t.string :email
      t.string :login_token
      t.datetime :login_token_valid_until

      t.timestamps
    end
    add_index :users, :email
    add_index :users, :login_token
  end
end
