FactoryGirl.define do
  factory :thermostat do
    household_token { SecureRandom.uuid }
    location { "HSr-2" }
  end
end
