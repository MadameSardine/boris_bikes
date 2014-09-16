require './lib/bike_container'
require './lib/bike'
require './lib/van'

class ContainerHolder; include BikeContainer; end

describe BikeContainer do

  let(:bike) { Bike.new }
  let(:holder) { ContainerHolder.new}

  it "should accept a bike" do        
    # we expect the holder to have 0 bikes
    expect(holder.bike_count).to eq(0)
    # let's dock a bike into the holder
    holder.dock(bike)    
    # now we expect the holder to have 1 bike
    expect(holder.bike_count).to eq(1)
  end

  it "should not accept anything than a bike" do
    not_a_bike = Van.new
    expect { holder.dock(not_a_bike) }.to raise_error(RuntimeError)
  end

  it "should raise an error if no argument in dock()" do
    expect { holder.dock() }.to raise_error(RuntimeError)
  end

  it "should raise an error if dock(nil)" do
    expect { holder.dock(nil) }.to raise_error(RuntimeError)
  end

  it "should release a bike" do
    holder.dock(bike)
    holder.release(bike)
    expect(holder.bike_count).to eq(0)
  end

  it "should know when it's full" do
    expect(holder).not_to be_full
    fill_holder holder
    expect(holder).to be_full
  end

  it "should not accept a bike if it's full" do
    fill_holder holder
    expect(lambda {holder.dock(bike) }).to raise_error(RuntimeError)
  end

  def fill_holder(holder)
    holder.capacity.times {holder.dock(Bike.new)}
  end

  it "should provide the list of available bikes" do
    working_bike, broken_bike = Bike.new, Bike.new
    broken_bike.break!
    holder.dock(working_bike)
    holder.dock(broken_bike)
    expect(holder.available_bikes).to eq([working_bike])
  end

  it "should only release a bike if it exists" do
  expect { holder.release(nil) }.to raise_error(RuntimeError) 
  end

  it "should raise an error if arg is empty in release(arg)" do
    expect{holder.release()}.to raise_error(RuntimeError)
  end

  it "should not release anything else than a bike" do
    not_a_bike = Van.new
    expect { holder.release(not_a_bike) }.to raise_error(RuntimeError)
  end

  it "should not release a bike if holder is empty" do
    expect {holder.release(bike)}.to raise_error(RuntimeError)
  end

  it "should not release a bike which is not in the container" do
    bike1, bike2 = Bike.new, Bike.new
    holder.dock(bike1)
    expect { holder.release(bike2)}.to raise_error(RuntimeError)
  end
end