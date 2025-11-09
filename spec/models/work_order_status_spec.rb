require 'rails_helper'

RSpec.describe WorkOrderStatus, type: :model do
  describe "validations" do
    it "allows only VALID_NAMES as name" do
      valid_names = WorkOrderStatus::VALID_NAMES
      valid_names.each do |name|
        status = WorkOrderStatus.new(name: name)
        expect(status).to be_valid
      end

      status = WorkOrderStatus.new(name: "invalid_name")
      expect(status).not_to be_valid
      expect(status.errors[:name]).to include("is not included in the list")
    end

  end

  describe "memoized class methods" do
    before(:each) do
      WorkOrderStatus::VALID_NAMES.each do |name|
        WorkOrderStatus.find_or_create_by!(name: name)
      end
    end

    it "returns the correct record for each memoized method" do
      WorkOrderStatus::VALID_NAMES.each do |name|
        WorkOrderStatus.remove_instance_variable("@#{name}") if WorkOrderStatus.instance_variable_defined?("@#{name}")
        status = WorkOrderStatus.send(name)
        expect(status).to be_a(WorkOrderStatus)
        expect(status.name).to eq(name)
      end
    end

    it "memoizes the records" do
      WorkOrderStatus.remove_instance_variable("@pending") if WorkOrderStatus.instance_variable_defined?("@pending")
      expect(WorkOrderStatus).to receive(:find_by).once.and_call_original
      first_call = WorkOrderStatus.pending
      second_call = WorkOrderStatus.pending

      expect(first_call.object_id).to eq(second_call.object_id)

    end

  end
end