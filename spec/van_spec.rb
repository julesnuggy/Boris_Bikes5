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
      station = DockingStation.new(Bike)
      bike1 = station.release_bike(1)
      bike2 = station.release_bike(2)
      bike1.report
      bike2.report
      station.dock(bike1, 1)
      station.dock(bike2, 2)
      van = Van.new
      van.collect_bikes(station)
      # Empty spaces where the bikes where originally docked
      expect(station.view_spaces).to include(1, 2)
      # No broken bikes in docking station
      expect(station.view_broken.empty?).to be_truthy
    end

    it "confirms there are broken bikes in van" do
      station = DockingStation.new(Bike)
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

   describe "return_bikes" do
     it "returns fixed bikes from van to docking station" do
       # Create docking station with 2 empty spaces at index 0 and 1
       station = DockingStation.new(Bike)
       station.bikes_in_station[0] = station.bikes_in_station[1] = nil

       # Create 2 undocked bikes and push onto van
       bike1 = bike2 = Bike.new
       bike1.release
       bike2.release
       van = Van.new
       van.van_store.push(bike1, bike2)

       # Return bikes to station
       van.return_bikes(station)

       expect(station.bikes_in_station).to include(bike1,bike2)
     end
   end

end
