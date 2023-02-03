class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :username, null: false
      t.text :password, null: false
      t.string :role, null: false
      t.string :session_token_id, null: false

      t.timestamps

      t.index %i[username role], unique: true
    end
  end
end
