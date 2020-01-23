# frozen_string_literal: true

# Add index to Users Table
class AddIndexOnUsers < ActiveRecord::Migration[5.0]
  def change
    add_index :users, :id
    add_index :users, :email_id
  end
end
