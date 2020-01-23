# frozen_string_literal: true

# Model for Interested Users
class InterestedUser < ActiveRecord::Base
  belongs_to :property
  belongs_to :user
  validates :property_id,:presence =>true
  validates :user_id,:presence =>true
end
