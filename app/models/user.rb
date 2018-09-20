class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :wikis, dependent: :destroy
  before_save :default_role

  enum role: [:standard, :premium, :admin]

  private 

  def default_role
    self.role ||= 0
  end
  
end
