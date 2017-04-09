class Exercise < ActiveRecord::Base
  belongs_to :athlete
  validates :name, :record, :date, :unit, :presence => true
  audited

  def revisions_in_order
    self.revisions.sort! { |a,b| a.date <=> b.date }
  end

  def convert_time
    Time.at(self.record).utc.strftime("%H:%M:%S")
  end
end
