class ThermostatsController < ApplicationController
	skip_before_action :verify_authenticity_token
	before_action :validate_params, only: [:create]
	#creating readings for a particular thermostat
	def create
	  if @thermostat.save!
	  	render status: 200, :json=>{:thermostats => @thermostat.thermostat_hash} and return
	  else
	  	render status: 400, :json=>{:error => "something wrong"} and return
	  end
	end  
private
	def validate_params
		thermostat_params = thermo_params
		thermostat_params.merge!("household_token" => SecureRandom.uuid)
		@thermostat = Thermostat.new(thermostat_params)
		if !@thermostat.valid?
     render json: { "errors" => @thermostat.errors } and return
    end
	end

  def thermo_params
    params.permit(:location,:household_token)
  end
end
