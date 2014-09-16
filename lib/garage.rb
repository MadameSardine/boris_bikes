# load BikeContainer
require_relative 'bike_container'

class Garage

  	# this gives us all the methods that used to be in this class
  	include BikeContainer

	alias_method :old_dock, :dock

  	def initialize(options = {})    
   		self.capacity = options.fetch(:capacity, capacity)
  	end
 
  	def dock(bike)
  		bike.fix!
  		old_dock(bike)
  	end
end