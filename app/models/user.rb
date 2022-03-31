class User < ApplicationRecord
  has_secure_password

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true

  has_many :states

  has_many :group_users
  has_many :groups, through: :group_users
end
