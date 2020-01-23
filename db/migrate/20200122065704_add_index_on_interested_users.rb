# frozen_string_literal: true

# Add index to Interested Users Table
class AddIndexOnInterestedUsers < ActiveRecord::Migration[5.0]
  def change
    add_index :interested_users, %i[property_id user_id]
    add_index :interested_users, :user_id
  end
end
