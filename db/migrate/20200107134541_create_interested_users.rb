# frozen_string_literal: true

# Create Interested Users Table
class CreateInterestedUsers < ActiveRecord::Migration
  def change
    create_table :interested_users do |t|
      t.integer :user_id
      t.integer :property_id
      t.timestamps null: false
    end
  end
end
