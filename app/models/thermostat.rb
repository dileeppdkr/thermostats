class Thermostat < ApplicationRecord
	validates :household_token, :presence => true, :uniqueness => true
  validates :location, :presence => true
  has_many :readings, dependent: :destroy

  def thermostat_hash
  	return {
  		id: self.id,
  		household_token: self.household_token,
  		location: self.location
  	}
  end
end
