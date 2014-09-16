# load BikeContainer
require_relative 'bike_container'

module GarageExtensions
	def dock(bike)
		bike.fix!
		super(bike)
	end
end

class Garage
	
	prepend GarageExtensions

  	# this gives us all the methods that used to be in this class
  	include BikeContainer

  	def initialize(options = {})    
   		self.capacity = options.fetch(:capacity, capacity)
  	end
end