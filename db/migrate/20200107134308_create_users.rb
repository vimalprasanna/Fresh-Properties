# frozen_string_literal: true

# Create Users Table
class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email_id
      t.string :password
      t.string :user_name
      t.bigint :contact_no
      t.timestamps null: false
    end
  end
end
