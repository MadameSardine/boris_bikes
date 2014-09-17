# load BikeContainer
require_relative 'bike_container'

class Van

  # this gives us all the methods that used to be in this class
  include BikeContainer

  def initialize(options = {})    
    self.capacity = options.fetch(:capacity, capacity)
  end

  def collect_from(holder)
	if holder.is_a?(DockingStation)
		then bikes_to_dock = holder.broken_bikes
	elsif holder.is_a?(Garage) 
		then bikes_to_dock = holder.available_bikes
	else raise 'The van can only collect from stations or garages'
	end
	bikes_to_dock.each do |bike| 
		raise 'The van is full' if full?
		holder.release(bike)
		dock(bike)
	end
  end

  def drop_off_to(recipient)
  	if recipient.is_a?(Garage)
  		then bikes_to_drop = broken_bikes
  	elsif recipient.is_a?(DockingStation)
  		then bikes_to_drop = available_bikes
  	else raise " The van can only drop off bikes to stations or garanges"
  	end
  	bikes_to_drop.each do |bike| 
  		raise "The recipient is full" if recipient.full?
  		release(bike) 
  		recipient.dock(bike)
  	end

  end

end