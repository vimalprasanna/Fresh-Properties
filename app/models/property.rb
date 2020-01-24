# frozen_string_literal: true

# Property model
class Property < ActiveRecord::Base
  belongs_to :owner, class_name: User
  has_attached_file :image
  has_one :tenant, class_name: User
  has_many :comments, dependent: :destroy
  has_many :users, through: :interested_user
  has_many :interested_users, dependent: :destroy
  validates_attachment_content_type :image, content_type: ['image/jpg',
                                                           'image/jpeg',
                                                           'image/png',
                                                           'image/gif']
  validates :rent, presence: true
  validates :location, presence: true
  validates :property_type, presence: true
  validates :name, presence: true, uniqueness: true

  def self.remove_tenant(property_id)
    @property = Property.find_by(id: property_id)
    @property.tenant_id = nil
    @property.save
  end

  def self.set_tenant(property_id, tenant_id)
    @property = Property.find_by(id: property_id)
    @property.tenant_id = tenant_id
    @property.save
  end
end
