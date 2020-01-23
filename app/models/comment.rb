# frozen_string_literal: true

# Model for Comments
class Comment < ActiveRecord::Base
  belongs_to :property
  belongs_to :sender, class_name: User
  has_one :receiver, class_name: User
  validates :property_id, presence: true
  validates :sender_id, presence: true
  validates :comment, presence: true
end
