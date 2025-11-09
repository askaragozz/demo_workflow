FactoryBot.define do
  factory :work_order do
    association :user
    work_type { ["Repair", "Installation", "Maintenance"].sample }
    description { Faker::Lorem.sentence }
    address { Faker::Address.full_address }
    latitude { Faker::Address.latitude }
    longitude { Faker::Address.longitude }

    # The status will be set automatically by the before_validation callback
    # but you can override it if needed
    after(:build) do |work_order|
      work_order.work_order_status ||= Status.find_or_create_by(type: "WorkOrderStatus", name: "pending")
    end
  end
end
