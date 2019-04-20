module ReadingsHelper
	#return aggregated data
	def get_aggregated_data db_data,redis_data,result
		db_data.each_with_index do |val,i|
		 val.each do |k,value|
		   avg_val = (value["avg"].to_f + redis_data[i][k]["avg"].to_f) / 2
		   min_val = [value["min"].to_f, redis_data[i][k]["min"].to_f].min
		   max_val = [value["max"].to_f, redis_data[i][k]["max"].to_f].max
		   result << {k => {"avg" => avg_val, "min" => min_val, "max" =>  max_val} }
		 end 
		end
		return result
	end
	#data from Redis
	def get_redis_data
		redis_data = []
		result = []
		redis_cache = $redis.keys
		unless redis_cache.empty?
		 redis_cache.each do |k|
		   reading = eval($redis.get(k))
		   next if !reading["household_token"].eql?(params[:household_token])
		   redis_data << { "temperature" => reading["temperature"], "humidity" => reading["humidity"], "battery_charge" => reading["battery_charge"] }
		 end
		end

		unless redis_data.blank?
		 thermostat_params = ["temperature", "humidity", "battery_charge"]
		 avg_data = get_avg_data(thermostat_params, redis_data)
		 min_data = get_min_data(thermostat_params, redis_data)
		 max_data = get_max_data(thermostat_params, redis_data)
		 result << {"temperature" => {"avg" => avg_data[0].round(2), "min" => min_data[0], "max" => max_data[0]}}
		 result << {"humidity" => {"avg" => avg_data[1].round(2), "min" => min_data[1], "max" => max_data[1]}}
		 result << {"battery_charge" => {"avg" => avg_data[2].round(2), "min" => min_data[2], "max" => max_data[2]}}
		end
		return result
	end

	#data from DB
	def get_thermostats_reading_aggregation
		result = []
		readings = @thermostat.readings
		aggregation = readings.size > 0 ? readings.pluck('Avg(temperature)', 'Min(temperature)', 'Max(temperature)', 'Avg(humidity)', 'Min(humidity)', 'Max(humidity)', 'Avg(battery_charge)', 'Min(battery_charge)', 'Max(battery_charge)').first : ""
		unless aggregation.empty?
		 result << {"temperature" => {"avg" => aggregation[0].round(2), "min" => aggregation[1], "max" => aggregation[2]}}
		 result << {"humidity" => {"avg" => aggregation[3].round(2), "min" => aggregation[4], "max" => aggregation[5]}}
		 result << {"battery_charge" => {"avg" => aggregation[6].round(2), "min" => aggregation[7], "max" => aggregation[8]}}
		end
		return result
	end 

	#calculate avg from redis data 
	def get_avg_data(thermostat_params, redis_data)
	 thermostat_params.map do |type|
	   redis_data.map { |x| x[type].to_f }.sum / redis_data.size
	 end
	end

	#calculate min from redis data
	def get_min_data(thermostat_params, redis_data)
	thermostat_params.map do |type|
	   redis_data.min_by { |h| h[type].to_i }[type]
	end
	end

	#calculate max from redis data
	def get_max_data(thermostat_params, redis_data)
	 thermostat_params.map do |type|
	   redis_data.max_by { |h| h[type].to_i }[type]
	 end
	end


end
