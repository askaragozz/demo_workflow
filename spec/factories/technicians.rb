FactoryBot.define do

  SPECIALIZATION_POOL = %w[electrician plumber carpenter painter hvac_technician welder mechanic mason roofer locksmith
appliance_repair glass_installer flooring_specialist drywall_installer landscaper gardener pest_control tiler handyman
solar_installer security_systems elevator_technician fire_alarm_specialist insulation_installer water_treatment_specialist]

  factory :technician do
    email { Faker::Internet.email }
    phone { Faker::PhoneNumber.cell_phone }
    name { Faker::Name.name }
    specializations { [SPECIALIZATION_POOL.sample]}
  end
end