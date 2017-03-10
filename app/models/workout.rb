class Workout < ActiveRecord::Base
  validates :date, :workout, :presence => true
  belongs_to :athlete

  def self.search(search)
    if search
      where('workout LIKE ?', "%#{search}%")
    else
      self.all
    end
  end

  scope :today, ->(athlete) { where(date: Time.zone.now.beginning_of_day).where(athlete_id: athlete.id) }

  scope :previous, ->(workout_date) {
    where("date < ?", workout_date).order("date DESC").first
  }

  scope :next, ->(workout_date) {
    where("date > ?", workout_date).order("date").first
  }

  scope :date_number, ->(date) {
    where(date: date).length
  }

end
