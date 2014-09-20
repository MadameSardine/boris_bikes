require './lib/person.rb'
require './lib/bike.rb'
require './lib/docking_station.rb'

describe Person do
	let(:person) {Person.new}
	let(:bike) {Bike.new}
	let(:station) {DockingStation.new}

	it 'should be able to initialize' do
		expect(person).not_to be_nil
	end

	it 'does not have a bike' do
		expect(person).not_to have_bike
	end

	it 'can have a bike' do
		person = Person.new(bike)
		expect(person).to have_bike
	end

	it 'can rent a bike from a station' do
		expect(station).to receive(:release_available_bike)
		person.rent_from(station)
	end

	it "has a bike after renting form a station" do
		station.dock(bike)
		person.rent_from(station)
		expect(person).to have_bike
	end

	it 'can return a bike to a station' do
		station.dock(bike)
		person.rent_from(station)
		person.return_to(station)
		expect(person).not_to have_bike
	end

	it 'it can not rent a bike from an empty station' do
		expect{person.rent_from(station)}.to raise_error(RuntimeError)
	end

	it 'can break a bike if it has an accident' do
		person = Person.new(bike)
		expect(bike).to receive(:break!)
		person.accident
	end

end