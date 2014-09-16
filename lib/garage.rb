# load BikeContainer
require_relative 'bike_container'

class Garage

  # this gives us all the methods that used to be in this class
  include BikeContainer

  def initialize(options = {})    
    self.capacity = options.fetch(:capacity, capacity)
  end

  def accept(bike)
  	bike.fix!
  	dock(bike)
  end
end