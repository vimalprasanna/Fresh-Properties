# frozen_string_literal: true

class Property < ActiveRecord::Base
  belongs_to :owner, class_name: User
  has_attached_file :image
  has_one :tenant, class_name: User
  has_many :comments
  has_many :users, through: :interested_user
  # has_many: :interested_users, dependent: :destroy
  validates_attachment_content_type :image, content_type: ['image/jpg', 'image/jpeg', 'image/png', 'image/gif']
  validates :rent, presence: true
  validates :location, presence: true
  validates :property_type, presence: true
  validates :name, presence: true, uniqueness: true
end
