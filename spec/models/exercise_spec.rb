require 'rails_helper'

describe Exercise do
  it { should belong_to :athlete }
  it { should validate_presence_of :date }
  it { should validate_presence_of :name }
  it { should validate_presence_of :record }
  it { should validate_presence_of :unit }
end
