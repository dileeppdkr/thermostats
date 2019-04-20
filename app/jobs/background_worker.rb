module BackgroundWorker
	class CreateReading
	  include Sidekiq::Worker
	  sidekiq_options retry: false
	  def self.perform(params, reading_id)
	    reading = Reading.new(:id => reading_id, :thermostat_id => params["thermostat_id"], :temperature => params["temperature"], :humidity => params["humidity"], :battery_charge => params["battery_charge"])
	    reading.save!
	  end
	end
end