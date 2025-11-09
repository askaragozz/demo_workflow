class WorkOrderStatus < Status  
  VALID_NAMES = %w[pending assigned in_progress completed cancelled].freeze
  
  validates :name, presence: true, inclusion: { in: VALID_NAMES }

  VALID_NAMES.each do |status_name|
    define_singleton_method(status_name) do
      instance_variable_get("@#{status_name}") || instance_variable_set("@#{status_name}", find_by(name: status_name, type: "WorkOrderStatus"))
    end
  end
end