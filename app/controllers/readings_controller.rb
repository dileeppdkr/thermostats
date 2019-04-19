class ReadingsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :get_thermostat
  before_action :validate_params, only: [:create]
  include ReadingsHelper

 #gives the avg, min and max by temerature, humidity and battery_charge for a particular thermostat
  def index
    result = []
    db_data = get_thermostats_reading_aggregation
    redis_data = get_redis_data
    if redis_data.empty?
     result = db_data
    elsif db_data.empty?
      result = redis_data
    else
      result = get_aggregated_data(db_data,redis_data,result)
    end
    render status: 200, :json=>{:thermostat_data => result} and return
 end 


 #creating readings for a particular thermostat
 def create
  puts '-=-=-=-=-=12'
    reading_id = Reading.next_sequence_id
    # params.delete :action
    # params.delete :controller
    puts '-=-=-=-=-=12'
    params.merge!("thermostat_id" => @thermostat.id)
    $redis.set(reading_id, params)
    ::BackgroundWorker::CreateReading.perform(params, reading_id)
    render status: 200, :json=>{:reading_id => reading_id} and return
 end

 #returns thermostat data for a particular reading
 def show
    reading = $redis.get(params[:id]) || Reading.find_by_id(params[:id])
    puts reading.inspect
    render status: 400, :json=>{ info: I18n.t('no_data')} and return if reading.nil?
    render status: 200, :json=>reading and return
 end

 private

  def check_params
    params.permit(:thermostat_id, :temperature, :humidity, :battery_charge)
  end

  def get_thermostat
    @thermostat = Thermostat.where(household_token: params[:household_token]).first
    puts @thermostat.inspect
    puts '-=-=-=-=-=-'
    render status: 400, :json=>{:status_code => 4001, :message => I18n.t('invalid_token')} and return if !@thermostat
    puts '-=-=-=-=-=-=-=-=-=-2'
  end

  def validate_params
    @reading = Reading.new(check_params)
    @reading.thermostat = @thermostat
    puts '-=-=-=-=-=-=-=-=3'
    if !@reading.valid?
      puts '-=-=-=-=-=-=-=-=4'
     render json: { "errors" => @reading.errors } and return
     puts '-=-=-=-=-=-=-=-=5'
    end
  end

end
