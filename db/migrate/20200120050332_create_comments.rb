# frozen_string_literal: true

# Create Comments table
class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.integer :sender_id
      t.integer :property_id
      t.text :comment
      t.timestamps
    end
  end
end
