class Reading < ApplicationRecord

	validates :battery_charge, :presence => true, :numericality => { :only_integer => true }
  validates :humidity, :presence => true, :numericality => { :only_float => true }
  validates :temperature, :presence => true, :numericality => { :only_float => true }
  belongs_to :thermostat
  after_create :clear_cache 

  #generates unique readings_id_seq
  def self.next_sequence_id 
    Reading.last.id+1
  end
 
  #clears cache data once reading created by sidekiq
  def clear_cache
    $redis.del self.id
  end

  def reading_hash
    return {
    "id": self.id,
    "thermostat_id": self.thermostat_id,
    "temperature": self.temperature,
    "humidity": self.humidity,
    "battery_charge": self.battery_charge
    }
  end

end
