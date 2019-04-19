module BackgroundWorker
class CreateReadingWorker
  include Sidekiq::Worker
  sidekiq_options retry: false

  def perform(params, reading_id)
  	puts '-=-=-=-=-=-=-=-=-'
    reading = Reading.new(:id => reading_id, :thermostat_id => params["thermostat_id"], :temperature => params["temperature"], :humidity => params["humidity"], :battery_charge => params["battery_charge"])
    reading.save!
  end
end
