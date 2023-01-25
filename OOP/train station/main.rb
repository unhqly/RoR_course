require_relative 'modules'
require_relative 'boxcar'
require_relative 'cargo_boxcar'
require_relative 'cargo_train'
require_relative 'passenger_boxcar'
require_relative 'passenger_train'
require_relative 'route'
require_relative 'station'
require_relative 'train'

class Main

  def initialize
    @stations_list = []
    @trains = []
    @routes = []
    @boxcars = []
  end

  def show_stations_list
    puts "List of stations"
    @stations_list.each.with_index(1) { |station, index| puts "#{index}. #{station.name}" } 
  end

  def show_common_trains_list
    puts "List of trains"
    @trains.each.with_index(1) { |train, index| puts "#{index}. №#{train.number}" } 
  end

  def show_routes_list
    puts "List of routes"
    @routes.each.with_index(1) { |route, index|
      print "#{index}. "
      route.stations.each { |station| puts "#{station.name} " }
    }
  end

  def show_boxcars_list
    @boxcars.each.with_index(1) { |boxcar, index| puts "#{index}. №#{boxcar.number}" } 
  end

  def create_station
    puts "Enter the name of the station to create"
    name = gets.chomp
    @stations_list.push(Station.new(name))
    show_stations_list
  end

  def create_train
    puts "Type 'Pass' or 'Cargo' to clarify type of train (Passenger or Cargo)"
    train_type = gets.chomp
    puts "Enter the number of train to create"
    number = gets.chomp
    if train_type == 'Pass'
      @trains.push(PassengerTrain.new(number))
    else
      @trains.push(CargoTrain.new(number))
    end  
    show_common_trains_list
  end

  def create_route
    puts "Enter first and last stations"
    start = gets.chomp
    finish = gets.chomp
    @stations_list.each { |station|
      if station.name == start
        start = station
      elsif station.name == finish
        finish = station
      end
    }
    @routes.push(Route.new(start, finish))
    show_routes_list
  end

  def create_boxcar
    puts "Type 'Pass' or 'Cargo' to clarify type of boxcar (Passenger or Cargo)"
    boxcar_type = gets.chomp
    puts "Enter the number of boxcar to create"
    number = gets.chomp
    if boxcar_type == 'Pass'
      @boxcars.push(PassengerBoxcar.new(number))
    else
      @boxcars.push(CargoBoxcar.new(number))
    end  
    show_boxcars_list
  end

  def operate_with_stations
    puts "Enter number of route"
    show_routes_list
    choosed_route_number = gets.chomp 

    puts "Enter number of station"
    show_stations_list
    choosed_station_number = gets.chomp

    puts "Type 'Add' to insert station or 'Del' to remove station"
    if gets.chomp == 'Add'
      puts "Enter the position to insert"
      position = gets.chomp.to_i
      @routes[choosed_route_number.to_i - 1].add_station(position, @stations_list[choosed_station_number.to_i - 1])
    else
      @routes[choosed_route_number.to_i - 1].delete_station(@stations_list[choosed_station_number.to_i - 1])
    end
    @routes[choosed_route_number.to_i - 1].show_route
    puts "\n"
  end

  def add_route_to_train
    puts "Enter number of route"
    show_routes_list  
    choosed_route_number = gets.chomp 

    puts "Enter number of train"
    show_common_trains_list 
    choosed_train_number = gets.chomp
    
    @trains[choosed_train_number.to_i - 1].add_route(@routes[choosed_route_number.to_i - 1])
  end

  def operate_with_boxcars
    puts "Enter number of train"
    show_common_trains_list
    choosed_train_number = gets.chomp

    puts "Enter number of boxcar"
    show_boxcars_list
    choosed_boxcar_number = gets.chomp

    puts "Type 'Add' to insert boxcar or 'Del' to remove boxcar"
    if gets.chomp == 'Add'
      @trains[choosed_train_number.to_i - 1].add_boxcar(@boxcars[choosed_boxcar_number.to_i - 1])
    else
      @trains[choosed_train_number.to_i - 1].delete_boxcar(@boxcars[choosed_boxcar_number.to_i - 1])
    end
  end

  def move_train
    puts "Enter number of train"
    show_common_trains_list  
    choosed_train_number = gets.chomp

    puts "Enter 'Fwd' to move forward or 'Back' to move back"
    if gets.chomp == "Fwd"
      @trains[choosed_train_number.to_i - 1].move_forward
    else
      @trains[choosed_train_number.to_i - 1].move_back
    end
  end

  def show_stations_train_list
    puts "Enter number of station"
    show_stations_list
    choosed_station_number = gets.chomp
    puts @stations_list[choosed_station_number.to_i - 1].trains
  end

  def show_menu
    puts "Enter '1' to create a station"
    puts "Enter '2' to create a train"
    puts "Enter '3' to create a route"
    puts "Enter '4' to create a boxcar"
    puts "Enter '5' to operate with stations in the route"
    puts "Enter '6' to add route to train"
    puts "Enter '7' to operate with boxcars"
    puts "Enter '8' to move a train"
    puts "Enter '9' to see train list at stations"
    puts "Enter '0' to exit"
  end
end

railway = Main.new

while true do
  railway.show_menu
  choice = gets.chomp.to_i

  case choice
  when 1
    railway.create_station
  when 2
    railway.create_train
  when 3
    railway.create_route
  when 4
    railway.create_boxcar
  when 5
    railway.operate_with_stations
  when 6
    railway.add_route_to_train
  when 7
    railway.operate_with_boxcars
  when 8
    railway.move_train
  when 9
    railway.show_stations_train_list
  when 0
    return
  else
    puts "Choose correct point"
  end
end 
