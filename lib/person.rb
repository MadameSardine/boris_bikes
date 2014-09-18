
class Person

def initialize(bike=nil) 
	@bike = bike
end 

def has_bike?
	@bike.is_a?(Bike)
end

def rent_from(station)
	@bike = station.release_available_bike
end

def return_to(station)
	station.dock(@bike)
	@bike = nil
end

def accident
	@bike.break!
end

end
