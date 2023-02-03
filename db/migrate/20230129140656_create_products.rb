# frozen_string_literal: true

class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :products do |t|
      t.integer :amount_available, null: false, default: 0
      t.decimal :cost, null: false, default: 0
      t.string :product_name
      t.string :reference, null: false

      t.timestamps

      t.index :reference, unique: true
    end
  end
end
