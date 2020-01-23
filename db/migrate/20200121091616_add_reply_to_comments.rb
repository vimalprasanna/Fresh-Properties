# frozen_string_literal: true

# Add Receiver Id to Comments
class AddReplyToComments < ActiveRecord::Migration[5.0]
  def change
    add_column :comments, :receiver_id, :integer
  end
end
