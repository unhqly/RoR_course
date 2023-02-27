# frozen_string_literal: true

module CompanyName
  attr_reader :company_name

  def company_name=(company_name)
    self.company_name = company_name
  end
end

module InstanceCounter
  def self.included(base)
    base.extend ClassMethods
    base.include InstanceMethods
  end

  module ClassMethods
    attr_writer :instances

    def instances
      @instances ||= 0
    end
  end

  module InstanceMethods
    def register_instance
      self.class.instances += 1
    end
  end
end

module InstanceValidation
  def valid?
    validate!
    true
  rescue ArgumentError
    false
  end
end

module StationHelper
  def show_stations_list
    puts 'List of stations'
    @stations_list.each.with_index(1) { |station, index| puts "#{index}. #{station.name}" }
  end

  def create_station
    puts 'Enter the name of the station to create'
    name = gets.chomp
    @stations_list.push(Station.new(name))
    show_stations_list
  rescue ArgumentError => e
    puts "#{e.message}. TRY AGAIN"
    retry
  end

  def show_stations_train_list
    puts 'Enter number of station'
    show_stations_list
    choosed_station_number = gets.chomp
    @stations_list[choosed_station_number.to_i - 1].show_trains_info do |train|
      print "№#{train.number} "
      puts train.is_a?(PassengerTrain) ? 'Passenger' : 'Cargo'
      puts "Amount of boxcars: #{train.boxcars.count}"
    end
  end

  def operate_with_stations
    puts "There're no routes" and return if @routes.count.zero?

    puts 'Enter number of route'
    show_routes_list
    choosed_route_number = gets.chomp.to_i

    puts 'Enter number of station'
    show_stations_list
    choosed_station_number = gets.chomp.to_i

    puts "Type 'add' to insert station or 'del' to remove station"
    operation_type = gets.chomp
    raise TypeError, 'Wrong type of operation' if operation_type != 'add' && operation_type != 'del'

    send("#{operation_type}_station", choosed_route_number, choosed_station_number)

    @routes[choosed_route_number - 1].show_route
    puts "\n"
  rescue TypeError => e
    puts "#{e.message}. TRY AGAIN"
    retry
  end

  def add_station(choosed_route_number, choosed_station_number)
    puts 'Enter the position to insert'
    position = gets.chomp.to_i
    @routes[choosed_route_number - 1].add_station(position, @stations_list[choosed_station_number - 1])
  end

  def del_station(choosed_route_number, choosed_station_number)
    if @routes[choosed_route_number - 1].stations.count == 1
      puts "Route can't include only 1 station"
    else
      @routes[choosed_route_number - 1].delete_station(@stations_list[choosed_station_number - 1])
    end
  end
end

module TrainHelper
  def show_common_trains_list
    puts 'List of trains'
    @trains.each.with_index(1) { |train, index| puts "#{index}. №#{train.number}" }
  end

  def create_train
    puts "Type 'Pass' or 'Cargo' to clarify type of train (Passenger or Cargo)"
    train_type = gets.chomp
    raise TypeError, 'Wrong type of train' if train_type != 'Pass' && train_type != 'Cargo'

    puts 'Enter the number of train to create'
    number = gets.chomp
    case train_type
    when 'Pass'
      @trains.push(PassengerTrain.new(number))
    when 'Cargo'
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

  def add_route_to_train
    puts 'Enter number of route'
    show_routes_list
    choosed_route_number = gets.chomp

    puts 'Enter number of train'
    show_common_trains_list
    choosed_train_number = gets.chomp

    @trains[choosed_train_number.to_i - 1].add_route(@routes[choosed_route_number.to_i - 1])
    puts "Route successfully added at train's route list"
    puts "Train successfully accepted at #{@routes[choosed_route_number.to_i - 1].stations[0].name} station"
  end

  def move_train
    puts 'Enter number of train'
    show_common_trains_list
    choosed_train_number = gets.chomp
    prev_station = @trains[choosed_train_number.to_i - 1].station

    puts "Enter 'Fwd' to move forward or 'Back' to move back"
    operation_type = gets.chomp
    raise TypeError, 'Wrong type of operation' if operation_type != 'Fwd' && operation_type != 'Back'

    case operation_type
    when 'Fwd'
      @trains[choosed_train_number.to_i - 1].move_forward
    when 'Back'
      @trains[choosed_train_number.to_i - 1].move_back
    end
    puts "Train №#{@trains[choosed_train_number.to_i - 1].number} left #{prev_station.name} station"
    puts "Train №#{@trains[choosed_train_number.to_i - 1].number} successfully accepted at #{@trains[choosed_train_number.to_i - 1].station.name} station"
  rescue RuntimeError
    puts 'There is no station in this direction'
  rescue TypeError => e
    puts "#{e.message}. TRY AGAIN"
    retry
  end
end

module BoxcarHelper
  def show_boxcars_list
    @boxcars.each.with_index(1) { |boxcar, index| puts "#{index}. №#{boxcar.number}" }
  end

  def create_boxcar
    puts "Type 'Pass' or 'Cargo' to clarify type of boxcar (Passenger or Cargo)"
    boxcar_type = gets.chomp
    raise TypeError, 'Wrong type of boxcar' if boxcar_type != 'Pass' && boxcar_type != 'Cargo'

    puts 'Enter the number and amount of seats (for passenger) or full volume (for cargo) to create boxcar'
    number = gets.chomp
    amount_of_content = gets.chomp
    case boxcar_type
    when 'Pass'
      @boxcars.push(PassengerBoxcar.new(number, amount_of_content))
    when 'Cargo'
      @boxcars.push(CargoBoxcar.new(number, amount_of_content))
    end
    show_boxcars_list
  rescue TypeError => e
    puts "#{e.message}. TRY AGAIN"
    retry
  rescue ArgumentError => e
    puts "#{e.message}. TRY AGAIN"
    retry
  end

  def operate_with_boxcars
    puts 'Enter number of train'
    show_common_trains_list
    choosed_train_number = gets.chomp

    puts 'Enter number of boxcar'
    show_boxcars_list
    choosed_boxcar_number = gets.chomp

    puts "Type 'add' to insert boxcar or 'del' to remove boxcar"
    operation_type = gets.chomp
    raise TypeError, 'Wrong type of operation' if operation_type != 'add' && operation_type != 'del'

    send("#{operation_type}_boxcar", choosed_train_number, choosed_boxcar_number)
  rescue RuntimeError
    puts 'Boxcar has wrong type'
  rescue TypeError => e
    puts "#{e.message}. TRY AGAIN"
    retry
  end

  def add_boxcar(choosed_train_number, choosed_boxcar_number)
    @trains[choosed_train_number.to_i - 1].add_boxcar(@boxcars[choosed_boxcar_number.to_i - 1])
    puts "Boxcar №#{@boxcars[choosed_boxcar_number.to_i - 1].number}
         successfully added to train №#{@trains[choosed_train_number.to_i - 1].number}".gsub("\n", '')
  end

  def del_boxcar(choosed_train_number, choosed_boxcar_number)
    @trains[choosed_train_number.to_i - 1].delete_boxcar(@boxcars[choosed_boxcar_number.to_i - 1])
    puts "Boxcar №#{@boxcars[choosed_boxcar_number.to_i - 1].number}
         deleted from train №#{@trains[choosed_train_number.to_i - 1].number}".gsub("\n", '')
  end

  def show_boxcars_of_train
    puts 'Enter number of train'
    show_common_trains_list
    choosed_train_number = gets.chomp
    puts 'Boxcars:'
    @trains[choosed_train_number.to_i - 1].show_boxcars_info do |boxcar|
      print "№#{boxcar.number} "
      puts boxcar.is_a?(PassengerBoxcar) ? 'Passenger' : 'Cargo'
      puts "Available volume: #{boxcar.available_volume}"
      puts "Occupied volume: #{boxcar.occupied_volume}"
    end
  end

  def take_seat_or_fill_boxcar
    show_boxcars_of_train
    puts 'Enter number of boxcar'
    choosed_boxcar_number = gets.chomp
    choosed_boxcar = @boxcars.select { |boxcar| boxcar if boxcar.number == choosed_boxcar_number }.first
    if choosed_boxcar.is_a?(PassengerBoxcar)
      choosed_boxcar.take_seat
      puts 'You took a seat successfully'
    else
      puts 'Enter the volume which you want to fill the boxcar for'
      volume = gets.chomp
      choosed_boxcar.fill_volume(volume)
      puts 'Boxcar filled up successfully'
    end
  end
end

module RouteHelper
  def show_routes_list
    puts 'List of routes'
    @routes.each.with_index(1) do |route, index|
      print "#{index}. "
      route.stations.each { |station| puts "#{station.name} " }
    end
  end

  def create_route
    if @stations_list.count >= 2
      puts 'Choose first and last stations'
      show_stations_list
      start = gets.chomp.to_i
      finish = gets.chomp.to_i
      start = @stations_list[start - 1]
      finish = @stations_list[finish - 1]
      @routes.push(Route.new(start, finish))
      show_routes_list
    elsif @stations_list.count == 1
      puts 'You need at least 2 stations to create a route'
      show_stations_list
    else
      puts "Stations list is empty. You can't create route without stations"
    end
  end
end
