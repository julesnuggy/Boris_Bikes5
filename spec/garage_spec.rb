require 'docking_station'

describe Garage do
  it "takes broken bikes from van" do
    bike1 = bike2 = Bike.new
    bike1.report
    bike2.report
    bike1.release
    bike2.release

    van = Van.new
    van.van_store.push(bike1, bike2)

    garage = Garage.new
    garage.receive_bikes(van)

    expect(van.van_store.empty?).to be_truthy
    expect(garage.garage_store).to include(bike1, bike2)
  end

  it "returns fixed bikes to van" do
    bike1 = bike2 = Bike.new
    bike1.release
    bike2.release

    garage = Garage.new
    garage.garage_store.push(bike1, bike2)
    van = Van.new

    garage.return_bikes(van)

    expect(van.van_store).to include(bike1, bike2)
  end
end
