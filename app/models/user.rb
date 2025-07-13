class User < ApplicationRecord
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :properties, foreign_key: 'owner_id', dependent: :nullify
  has_one :rented_property, class_name: 'Property', foreign_key: 'tenant_id', dependent: :nullify
end
