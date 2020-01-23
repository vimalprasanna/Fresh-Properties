# frozen_string_literal: true

require 'bcrypt'
# Model for Users
class User < ActiveRecord::Base
  include BCrypt
  before_save { self.email_id = email_id.downcase }
  has_many :interested_properties, class_name: Property,
                                   through: :interested_users
  has_many :properties
  belongs_to :property
  EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i.freeze
  validates :user_name, presence: true, length: { in: 3..20 }
  validates :email_id, presence: true, uniqueness: true, format: EMAIL_REGEX
  validates :password, presence: true

  def password
    @password ||= Password.new(password_hash)
  end

  def password=(password_hash)
    @password = Password.create(password_hash)
    self.password_hash = @password
  end
  
end
