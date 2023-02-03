class CreateWallets < ActiveRecord::Migration[7.0]
  def change
    create_table :wallets do |t|
      t.belongs_to :user
      t.integer :deposit, default: 0
      t.timestamps
    end

    add_foreign_key :wallets, :users, delete: :cascade
  end
end
