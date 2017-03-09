require 'rails_helper'

RSpec.describe Coach, type: :model do
  it {should have_many :athletes}
  it { should validate_presence_of :first_name }
  it { should validate_presence_of :last_name }
end
