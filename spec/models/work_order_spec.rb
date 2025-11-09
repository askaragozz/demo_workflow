require 'rails_helper'

RSpec.describe WorkOrder, type: :model do
  # Common test data
  let(:user) { create(:user) }

  # ------------------------------------------------------------------
  describe "associations" do
    it { should belong_to(:user) }
    it { should belong_to(:technician).optional }

    it "belongs to work_order_status with correct class and foreign key" do
      association = described_class.reflect_on_association(:work_order_status)
      expect(association.macro).to eq(:belongs_to)
      expect(association.class_name).to eq('Status')
      expect(association.foreign_key).to eq('status_id')
    end
  end

  # ------------------------------------------------------------------
  describe "validations" do
    subject(:work_order) { build(:work_order, user: user) }

    it { should validate_presence_of(:work_type) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:address) }
    it { should validate_presence_of(:latitude) }
    it { should validate_presence_of(:longitude) }
    it { should validate_presence_of(:user_id) }

    it "is valid with valid attributes" do
      expect(work_order).to be_valid
    end
  end

  # ------------------------------------------------------------------
  describe "callbacks" do
    context "when work_order_status is not set" do
      let(:work_order) { build(:work_order, user: user, work_order_status: nil) }
      let!(:pending_status) { create(:status, type: "WorkOrderStatus", name: "pending") }

      it "sets default status to pending before validation" do
        work_order.valid?
        expect(work_order.status).to eq(pending_status.name)
      end
    end

    context "when work_order_status is already set" do
      let(:custom_status) { create(:status, type: "WorkOrderStatus", name: "in_progress") }
      let(:work_order) { build(:work_order, user: user, work_order_status: custom_status) }

      it "does not override the existing status" do
        work_order.valid?
        expect(work_order.work_order_status).to eq(custom_status)
      end
    end
  end

end
