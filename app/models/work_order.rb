class WorkOrder < ApplicationRecord

  belongs_to :user
  belongs_to :technician, optional: true
  belongs_to :work_order_status, -> { where(type: "WorkOrderStatus") }, class_name: "Status", foreign_key: :status_id

  validates :user_id, presence: true
  validates :work_type, presence: true
  validates :description, presence: true
  validates :work_order_status, presence: true
  validates :address, presence: true
  validates :latitude, presence: true
  validates :longitude, presence: true

  before_validation :set_default_status

  def status
    work_order_status&.name
  end

  private

  def set_default_status
    self.work_order_status ||= WorkOrderStatus.find_by(name: "pending")
  end

end