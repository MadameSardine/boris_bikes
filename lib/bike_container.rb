module BikeContainer

  DEFAULT_CAPACITY = 20

  def bikes
    @bikes ||= []
  end

  def capacity    
    @capacity ||= DEFAULT_CAPACITY
  end

  def capacity=(value)    
    @capacity = value
  end

  def bike_count
    bikes.count
  end

  def dock(bike=nil)
    raise_not_a_bike_error_msg(bike)
    raise "Maximum capacity is reached" if full?
    bikes << bike
  end

  def raise_not_a_bike_error_msg(bike)
     raise "This is not a bike" if !bike.is_a?(Bike)
   end

  def release(bike=nil)
     raise_not_a_bike_error_msg(bike)
     raise "There is no bike in the container" if bike_count == 0
     raise "This bike is not in this container" if !bikes.include? bike
    bikes.delete(bike)
  end

  def full?
    bike_count == capacity
  end

  def available_bikes
    bikes.reject {|bike| bike.broken? }
  end

   def broken_bikes 
    bikes.select{ |bike| bike.broken? }
  end

  def empty?
    bike_count == 0
  end
end