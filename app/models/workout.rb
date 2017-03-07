class Workout < ActiveRecord::Base
  validates :date, :workout, :presence => true
  belongs_to :athlete
end
