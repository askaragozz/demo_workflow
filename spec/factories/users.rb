FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    phone { Faker::PhoneNumber.cell_phone }
    # Add other required user attributes based on your User model
  end
end