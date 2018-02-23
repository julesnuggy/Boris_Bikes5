require 'docking_station'

describe Van do
  describe "can take broken bikes from docking stations" do
    let(:station) { double :station }
    let(:bike1) { double :bike }
    let(:bike2) { double :bike }

    it "removes broken bikes from docking station " do
#      allow(bike1).to receive(:report).and_return(false)
#      allow(bike2).to receive(:report).and_return(false)
#      allow(station).to receive(:dock).and_return(["bike_ID_1", @dock_status=true, @working=false])
#      allow(station).to receive(:dock).and_return(["bike_ID_2", @dock_status=true, @working=false])
      station = DockingStation.new
      bike1 = station.release_bike(1)
      bike2 = station.release_bike(2)
      bike1.report
      bike2.report
      station.dock(bike1, 1)
      station.dock(bike2, 2)
      van = Van.new
      van.collect_bikes(station)
      # Empty spaces where the bikes where originally docked
      expect(station.view_spaces).to include("1", "2")
      # No broken bikes in docking station
      expect(station.view_broken.empty?).to be_truthy
    end

    it "confirms there are broken bikes in van" do
      station = DockingStation.new
      bike1 = station.release_bike(1)
      bike2 = station.release_bike(2)
      bike1.report
      bike2.report
      station.dock(bike1, 1)
      station.dock(bike2, 2)
      van = Van.new
      van.collect_bikes(station)
      expect(van.van_store).to include(bike1,bike2)
    end
  end

  # describe "vans deliver broken bikes to garages" do
  #   it "" do
  #   end
  # end
end
