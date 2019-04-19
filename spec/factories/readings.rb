FactoryGirl.define do
  factory :reading do
    thermostat_id { 1 }
    temperature { 3.2 }
    humidity { 2.4 }
    battery_charge { 49 }
    sequence_number { 13 }
  end
end
