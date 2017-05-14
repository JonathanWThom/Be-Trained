class Exercise < ActiveRecord::Base
  belongs_to :athlete
  validates :name, :record, :date, :unit, :presence => true
  audited

  UNITS = [
    "Pounds",
    "Kilograms",
    "Seconds"
  ]

  def fixed_record
    if unit == "Seconds"
      convert_time
    else
      record
    end
  end

  def revisions_in_order
    self.revisions.sort! { |a,b| b.date <=> a.date }
  end

  def convert_time
    Time.at(self.record).utc.strftime("%H:%M:%S")
  end

  def pretty_date
    date.strftime("%B %e, %Y")
  end

end
