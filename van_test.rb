require "./lib/docking_station.rb"

station = DockingStation.new(Bike)
bike1 = station.release_bike(0)
bike2 = station.release_bike(1)

bike1.report
bike2.report

station.dock(bike1, 0)
station.dock(bike2, 1)

#van_bikes = station.view_broken
#p van_bikes

van = Van.new
van.collect_bikes(station)

#station.view_broken
#station.view_spaces


garage = Garage.new
garage.receive_bikes(van)

garage.fix("all")
garage.return_bikes(van)

#station.bikes_in_station[2].push(bike1)
van.return_bikes(station)
