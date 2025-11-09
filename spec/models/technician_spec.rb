require 'rails_helper'

RSpec.describe Technician, type: :model do
  describe "validations" do
    let(:technician) { build(:technician) }

    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:phone) }

    it "is valid with valid attributes" do
      expect(technician).to be_valid
    end

    it "Technician must have at least one specialization" do
      technician.specializations = []
      expect(technician).not_to be_valid
      expect(technician.errors[:specializations]).to include("Must have at least one specialization")
    end

  end
end