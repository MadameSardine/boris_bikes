require './lib/van'
require './lib/docking_station'
require './lib/bike'
require './lib/garage'

describe Van do

	let(:van) { Van.new(:capacity => 30) }
	let(:bike) { Bike.new }
	let(:broken_bike) { Bike.new }
	let(:garage) {Garage.new(:capacity => 20)}
	let(:station){DockingStation.new(:capacity => 123)}

	it "should allow setting default capacity on initialising" do
		expect(van.capacity).to eq(30);
	end	

	it "should only collect broken bikes from stations" do 
		station.dock(bike)
		broken_bike.break!
		station.dock(broken_bike)
		van.collect_from(station)
		expect(van.bikes).to eq([broken_bike])
	end

	it "should only collect working bikes from garages" do
		garage.dock(broken_bike)
		van.collect_from(garage)
		expect(van.bikes).to eq([broken_bike])
	end

	it 'should only collect as many bikes as it can take' do
		garage = Garage.new(:capacity => 40)
		40.times do
			bike = Bike.new
			garage.dock(bike)
		end
		expect{ van.collect_from(garage)}.to raise_error(RuntimeError)
	end


	def dock_bike_and_broken_bike_in_van 
		van.dock(bike)
		broken_bike.break!
		van.dock(broken_bike)	
	end

	it 'should only release broken bikes to garage' do
		dock_bike_and_broken_bike_in_van 
		van.drop_off_to(garage)
		expect(van.broken_bikes.count).to eq(0)
		expect(van.available_bikes.count).to eq(1)
	end

	it 'should only release as many broken bikes as the garage can take' do
		30.times do 
			broken_bike = Bike.new
			broken_bike.break!
			van.dock(broken_bike)
		end
		expect{van.drop_off_to(garage)}.to raise_error(RuntimeError)
	end

	it 'should only release working bikes to station' do
		dock_bike_and_broken_bike_in_van
		van.drop_off_to(station)
		expect(van.available_bikes.count).to eq(0)
		expect(van.broken_bikes.count).to eq(1)
 	end

 	it 'should only drop of a broken bike to the garage if the garage can dock it' do
    	dock_bike_and_broken_bike_in_van
    	expect(garage).to receive(:dock)
    	van.drop_off_to(garage)
  	end
end