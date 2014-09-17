require './lib/docking_station'
require './lib/bike'

describe DockingStation do

  let(:station) { DockingStation.new(:capacity => 123) }

  it "should allow setting default capacity on initialising" do
    expect(station.capacity).to eq(123)
  end

  it 'can release a working bike to a person' do
    bike = Bike.new
    station.dock(bike)
    broken_bike = Bike.new
    broken_bike.break!
    station.dock(broken_bike)
    expect(station.release_available_bike).to eq(bike)
  end
  
end