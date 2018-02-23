class DockingStation
  attr_reader :bikes_in_station, :capacity

  DEFAULT_CAPACITY = 20

  def initialize(capacity = DEFAULT_CAPACITY)
    @bikes_in_station = []
    @capacity = capacity
    @capacity.times{@bikes_in_station << Bike.new}
  end

  def release_bike(idx)
    fail "No bikes at this station" if @bikes_in_station.count(nil) == DEFAULT_CAPACITY
    fail "No bike here" if @bikes_in_station[idx] == nil
    fail "Bike is broken" if @bikes_in_station[idx].working == false
      released_bike = @bikes_in_station[idx]
      released_bike.release
      @bikes_in_station[idx] = nil
      released_bike
  end

  def dock(bike, idx)
    fail "The station is full" if full?
    fail "Dock is occupied" if @bikes_in_station[idx] != nil
      @bikes_in_station[idx] = bike
      bike.dock
  end

  def view_spaces
    empty_spaces = []
    @bikes_in_station.each_with_index { |val, index|
      empty_spaces.push(index) if val == nil
    }
    p "Empty spaces found at #{empty_spaces}"
  end

  def view_working
    working_bikes = []
    @bikes_in_station.each_with_index { |val, index|
      if val != nil
        working_bikes.push(index) if val.working
      end
    }
    p "Working bikes found at #{working_bikes}"
    working_bikes
  end


  def view_broken
    broken_bikes = []
    @bikes_in_station.each_with_index { |val, index|
      if val != nil
        broken_bikes.push(index) if !val.working
      end
    }
    p "Broken bikes found at #{broken_bikes}"
    broken_bikes
  end

  private
  def full?
    if @bikes_in_station.include?(nil)
      false
    else
      true
    end
  end

end


class Bike
  attr_reader :dock_status
  attr_accessor :working

  def initialize
    @dock_status = "docked"
    @working = true
  end

  def dock
    @dock_status = "docked"
  end

  def release
    @dock_status = "undocked"
  end

  def report
    @working = false
  end

end


class Van
  # Van takes broken bikes from dock to garage
  # Van takes fixed bikes from garage to dock

  attr_accessor :van_store

  def initialize
    @van_store = []
  end

  def collect_bikes(station)
    # Get array of indices of where broken bikes are in station
    van_bikes = station.view_broken

    # Loop through this array and, for each indexed-bike, undock the bike
    # Replace the undocked bike object with nil in the station array
    # Push bike object to @van_store array
    van_bikes.each { |dock_index|
      released_bike = station.bikes_in_station[dock_index]
      released_bike.release
      station.bikes_in_station[dock_index] = nil
      @van_store.push(released_bike)
    }

    p "Collected broken bikes: #{@van_store}"
    @van_store
  end

  def return_bikes()
  end

end

class Garage
  # Garage takes broken bikes from Van
  # Garage returns fixed bikes to Van

  attr_accessor :garage_store

  def initialize
    @garage_store = []
  end

  def receive_bikes(van)
    # Add broken bikes on van to garage_store
    @garage_store += van.van_store
    # Clear van_store array as van is now empty
    van.van_store.clear

    p "Received broken bikes: #{garage_store}"
  end

  def fix(bikes)
    if bikes == "all"
      @garage_store.each { |bike|
        bike.working = true
      }
    else
      
    end
    p "Fixed bikes: #{garage_store}"
  end

  def return_bikes(van)
    # Loop through each |bike| element in garage
    @garage_store.each { |bike|
      # If bike is fixed (i.e. working) then
      if bike.working == true
        # push bike to van
        van.van_store.push(bike)
        # and remove from garage
        @garage_store.delete(bike)
      end
    }
    p "Returned broken bikes: #{van.van_store}"
    p "Van now contains: #{van.van_store}"
    p "Garage now contains: #{garage_store}"

  end

end
