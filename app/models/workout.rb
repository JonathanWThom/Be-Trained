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

  scope :today, -> { where(date: Date.today) }
  
end
