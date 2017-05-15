require 'rails_helper'

describe Exercise do
  it { should belong_to :athlete }
  it { should validate_presence_of :date }
  it { should validate_presence_of :name }
  it { should validate_presence_of :record }
  it { should validate_presence_of :unit }

  describe "#convert_time" do
    it "will print out a record's time as hr:min:sec" do
      exercise = create(:exercise, record: 300, unit: "Seconds")
      expect(exercise.convert_time).to eq("00:05:00")
    end
  end
  describe "#fixed_record" do
    it "will return time in minutes format if record is in seconds" do
      exercise = create(:exercise, record: 300, unit: "Seconds")
      expect(exercise.fixed_record).to eq("00:05:00")
    end

    it "will record regular record if format is not in seconds" do
      exercise = create(:exercise)
      expect(exercise.fixed_record).to eq(400)
    end
  end
end
