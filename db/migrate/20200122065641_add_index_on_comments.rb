# frozen_string_literal: true

# Add index to Comments Table
class AddIndexOnComments < ActiveRecord::Migration[5.0]
  def change
    add_index :comments, :property_id
    add_index :comments, :created_at
  end
end
