FactoryGirl.define do
	
  factory :thermostat do
    household_token SecureRandom.uuid 
    location "Bangalore" 
  end

  factory :reading do
    thermostat_id 1
   	temperature  1.5 
    humidity  1.5 
    battery_charge  1 
    sequence_number  1 
  end

end