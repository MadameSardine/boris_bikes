require './lib/garage.rb'
require './lib/bike.rb'

describe Garage do 

	let(:garage) { Garage.new(:capacity => 20) }
	let(:bike) { Bike.new }

	it "should allow setting default capacity on initialising" do
		expect(garage.capacity).to eq(20);
	end	

	it "should only dock fixed bikes" do
		bike.break!
		garage.dock(bike)
		expect(bike).not_to be_broken
 	end
end