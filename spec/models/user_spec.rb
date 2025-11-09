require 'rails_helper'

RSpec.describe User, type: :model do
  describe "validations" do
    let(:user) { create(:user) }

    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:phone) }

    it "is valid with valid attributes" do
      expect(user).to be_valid
    end

  end
end