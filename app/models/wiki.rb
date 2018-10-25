class Wiki < ApplicationRecord
  belongs_to :user
  has_many :collaborators
  has_many :users
  extend FriendlyId
  friendly_id :title, use: :slugged
end
