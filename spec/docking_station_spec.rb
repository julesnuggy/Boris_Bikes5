require 'docking_station'

describe DockingStation do
  describe "Docking Station allows releasing and docking of bikes" do
    it { is_expected.to respond_to :release_bike }
    it { expect(subject.release_bike(1)).to be_a Bike }
    it { expect(subject.release_bike(1).working).to eq true }
    it { is_expected.to respond_to :dock }
  end

  describe "raise errors depending on dock and bike availability" do
    it "raises an error when no bike available" do
      expect {
        station = DockingStation.new
        for i in 0..(DockingStation::DEFAULT_CAPACITY + 1)
          station.release_bike(i)
        end
      }.to raise_error("No bikes at this station")
    end

    it "raises an error when the dock is empty" do
      expect {
        station = DockingStation.new
        station.release_bike(1)
        station.release_bike(1)
      }.to raise_error("No bike here")
    end

    it "raises an error when the station is full" do
      expect {
        station1 = DockingStation.new
        station2 = DockingStation.new
        bike1 = station1.release_bike(1)
        station2.dock(bike1, 1)
      }.to raise_error("The station is full")
    end

  it "raises an error when the dock is occupied" do
    expect {
      station1 = DockingStation.new
      bike1 = station1.release_bike(1)
      station1.dock(bike1, 2)
    }.to raise_error("Dock is occupied")
  end
end

  describe "control dock capacity" do
    it "sets the docking station capacity to DEFAULT_CAPACITY" do
      expect(DockingStation.new().capacity).to eq(20)
    end

    it "allows the user to set their own capacity value" do
      expect(DockingStation.new(30).capacity).to eq(30)
    end
  end

  describe "control bike broken" do
    it "raises an error when trying to release bike if the bike is broken" do
      expect {
        station = DockingStation.new
        bike = station.release_bike(1)
        bike.report
        station.dock(bike, 1)
        station.release_bike(1)
      }.to raise_error("Bike is broken")
    end
  end

end
