# frozen_string_literal: true

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
  include StationHelper
  include TrainHelper
  include BoxcarHelper
  include RouteHelper
  
  attr_reader :stations_list

  def initialize
    @stations_list = []
    @trains = []
    @routes = []
    @boxcars = []
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
    puts "Enter '10' to see information about boxcars of trains"
    puts "Enter '11' to take a seat or fill the boxcar"
    puts "Enter '0' to exit"
  end
end

railway = Main.new

loop do
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
  when 10
    railway.show_boxcars_of_train
  when 11
    railway.take_seat_or_fill_boxcar
  when 0
    return
  else
    puts 'Choose correct point'
  end
end
