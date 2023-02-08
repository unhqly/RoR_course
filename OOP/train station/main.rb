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
  rescue ArgumentError => e
    puts "#{e.message}. TRY AGAIN"
    retry
  end

  def create_train
    puts "Type 'Pass' or 'Cargo' to clarify type of train (Passenger or Cargo)"
    train_type = gets.chomp
    raise TypeError, 'Wrong type of train' if train_type != 'Pass' && train_type != 'Cargo'
    puts "Enter the number of train to create"
    number = gets.chomp
    if train_type == 'Pass'
      @trains.push(PassengerTrain.new(number))
    elsif train_type == 'Cargo'
      @trains.push(CargoTrain.new(number))
    end  
    puts "Train №#{number} successfully created"
    show_common_trains_list
  rescue TypeError => e
    puts "#{e.message}. TRY AGAIN"
    retry 
  rescue ArgumentError => e
    puts "#{e.message}. TRY AGAIN"
    retry
  end

  def create_route
    if @stations_list.count >= 2
      puts "Choose first and last stations"
      show_stations_list
      start = gets.chomp.to_i
      finish = gets.chomp.to_i
      start = @stations_list[start-1]
      finish = @stations_list[finish-1]
      @routes.push(Route.new(start, finish))
      show_routes_list
    elsif @stations_list.count == 1
      puts "You need at least 2 stations to create a route"
      show_stations_list
    else
      puts "Stations list is empty. You can't create route without stations"
    end
  end

  def create_boxcar
    puts "Type 'Pass' or 'Cargo' to clarify type of boxcar (Passenger or Cargo)"
    boxcar_type = gets.chomp
    raise TypeError, 'Wrong type of boxcar' if boxcar_type != 'Pass' && boxcar_type != 'Cargo'
    puts "Enter the number of boxcar to create"
    number = gets.chomp
    if boxcar_type == 'Pass'
      @boxcars.push(PassengerBoxcar.new(number))
    elsif boxcar_type == 'Cargo'
      @boxcars.push(CargoBoxcar.new(number))
    end  
    show_boxcars_list
  rescue TypeError => e
    puts "#{e.message}. TRY AGAIN"
    retry 
  rescue ArgumentError => e
    puts "#{e.message}. TRY AGAIN"
    retry
  end

  def operate_with_stations
    if @routes.count > 0
      puts "Enter number of route"
      show_routes_list
      choosed_route_number = gets.chomp.to_i

      puts "Enter number of station"
      show_stations_list
      choosed_station_number = gets.chomp.to_i

      puts "Type 'Add' to insert station or 'Del' to remove station"
      operation_type = gets.chomp
      raise TypeError, 'Wrong type of operation' if operation_type != 'Add' && operation_type != 'Del'
      if operation_type == 'Add'
        puts "Enter the position to insert"
        position = gets.chomp.to_i
        @routes[choosed_route_number - 1].add_station(position, @stations_list[choosed_station_number - 1])
      elsif operation_type == 'Del'
        if @routes[choosed_route_number - 1].stations.count == 1
          puts "Route can't include only 1 station"
        else
          @routes[choosed_route_number - 1].delete_station(@stations_list[choosed_station_number - 1])
        end
      end
      @routes[choosed_route_number - 1].show_route
      puts "\n"
    else
      puts "There're no routes"
    end
    rescue TypeError => e
      puts "#{e.message}. TRY AGAIN"
      retry
  end

  def add_route_to_train
    puts "Enter number of route"
    show_routes_list  
    choosed_route_number = gets.chomp 

    puts "Enter number of train"
    show_common_trains_list 
    choosed_train_number = gets.chomp
    
    @trains[choosed_train_number.to_i - 1].add_route(@routes[choosed_route_number.to_i - 1])
    puts "Route successfully added at train's route list"
    puts "Train successfully accepted at #{@routes[choosed_route_number.to_i - 1].stations[0].name} station"
  end

  def operate_with_boxcars
    puts "Enter number of train"
    show_common_trains_list
    choosed_train_number = gets.chomp

    puts "Enter number of boxcar"
    show_boxcars_list
    choosed_boxcar_number = gets.chomp

    puts "Type 'Add' to insert boxcar or 'Del' to remove boxcar"
    operation_type = gets.chomp
    raise TypeError, 'Wrong type of operation' if operation_type != 'Add' && operation_type != 'Del'
    if operation_type == 'Add'
      @trains[choosed_train_number.to_i - 1].add_boxcar(@boxcars[choosed_boxcar_number.to_i - 1])
      puts "Boxcar №#{@boxcars[choosed_boxcar_number.to_i - 1].number} successfully added to train №#{@trains[choosed_train_number.to_i - 1].number}"
    elsif operation_type == 'Del'
      @trains[choosed_train_number.to_i - 1].delete_boxcar(@boxcars[choosed_boxcar_number.to_i - 1])
      puts "Boxcar №#{@boxcars[choosed_boxcar_number.to_i - 1].number} deleted from train №#{@trains[choosed_train_number.to_i - 1].number}"
    end
  rescue RuntimeError
    puts "Boxcar has wrong type"
  rescue TypeError => e
    puts "#{e.message}. TRY AGAIN"
    retry
  end

  def move_train
    puts "Enter number of train"
    show_common_trains_list  
    choosed_train_number = gets.chomp
    prev_station = @trains[choosed_train_number.to_i - 1].station

    puts "Enter 'Fwd' to move forward or 'Back' to move back"
    operation_type = gets.chomp
    raise TypeError, 'Wrong type of operation' if operation_type != 'Fwd' && operation_type != 'Back'
    if operation_type == "Fwd"
      @trains[choosed_train_number.to_i - 1].move_forward
    elsif operation_type == "Back"
      @trains[choosed_train_number.to_i - 1].move_back
    end
    puts "Train №#{@trains[choosed_train_number.to_i - 1].number} left #{prev_station.name} station"
    puts "Train №#{@trains[choosed_train_number.to_i - 1].number} successfully accepted at #{@trains[choosed_train_number.to_i - 1].station.name} station"
  rescue RuntimeError 
    puts "There is no station in this direction"
  rescue TypeError => e
    puts "#{e.message}. TRY AGAIN"
    retry
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
