require 'docking_station'

describe DockingStation do
  let(:new_bike) { double(:new => docked_bike) }
  let(:docked_bike) { double(:release_bike => "bike object", :dock => "docked", :release => "undocked", :working => true) }
  let(:working_bike) { double(:release_bike => "bike object", :dock => "docked", :release => "undocked", :working => true, :report => false) }
  let(:broken_bike) { double(:release_bike => "bike object", :dock => "docked", :release => "undocked", :working => false, :report => false) }

  describe "Docking Station allows releasing and docking of bikes" do


    it "releases a working bike" do

      #Set up a test where we arbitrarily create an array of "bikes"
      #and test that when we dock a "bike" the "bike" is where we expect it
      #and test that when we release "bike" we get "bike".

      expect(working_bike.release_bike(1)).to eq "bike object"
      expect(working_bike.working).to eq true

    end

  end

  #describe "raise errors depending on dock and bike availability" do

    it "raises an error when no bike available" do
      #a_bike = double(:dock => "docked", :release => "undocked", :release_bike => Bike, :working => true)
      #new_bike = double(:new => a_bike)

      expect {
        station = DockingStation.new(new_bike)
        for i in 0..(DockingStation::DEFAULT_CAPACITY + 1)
          station.release_bike(i)
        end
      }.to raise_error("No bikes at this station")
    end

    it "raises an error when the dock is empty" do
      expect {
        station = DockingStation.new(new_bike)
        station.release_bike(1)
        station.release_bike(1)
      }.to raise_error("No bike here")
    end

    it "raises an error when the station is full" do
      expect {
        station1 = DockingStation.new(new_bike)
        station2 = DockingStation.new(new_bike)
        bike1 = station1.release_bike(1)
        station2.dock(bike1, 1)
      }.to raise_error("The station is full")
    end

  it "raises an error when the dock is occupied" do
    expect {
      station1 = DockingStation.new(new_bike)
      bike1 = station1.release_bike(1)
      station1.dock(bike1, 2)
    }.to raise_error("Dock is occupied")
  end
#end

  describe "control dock capacity" do
    it "sets the docking station capacity to DEFAULT_CAPACITY" do
      expect(DockingStation.new(new_bike).capacity).to eq(20)
    end

    it "allows the user to set their own capacity value" do
      expect(DockingStation.new(new_bike, 30).capacity).to eq(30)
    end
  end

  describe "control bike broken" do
    it "raises an error when trying to release bike if the bike is broken" do
      expect {
        station = DockingStation.new(new_bike)
        broken_bike.report
        station.dock(broken_bike, 1)
        station.release_bike(1)
      }.to raise_error("Bike is broken")
    end
  end

end
