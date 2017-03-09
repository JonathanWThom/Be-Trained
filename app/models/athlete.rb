class Athlete < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  belongs_to :coach
  validates :first_name, :last_name, :presence => true
  has_many :workouts

  scope :confirmed, -> { where(confirmed: true) }
  scope :unconfirmed, -> { where(confirmed: false) }

end
