=begin
Challenge #289 [Intermediate] Metro trip planner

The prupose of this challenge is to help user to find the quickest way to go from a metro station to another.

As an input the program receives the table which provide connexions between stations and the time associated (see input.txt).
The metro map is the following: http://imgur.com/9K060Fr
Then it asks the user to provide two stops. The first is where the user is at. The second is where the users wants to go.

As a result it shows possible routes to the point the users wants to go.

=end



class Metro

  def initialize
    @stations = Hash.new
  end

  # Gets a metro map
	def get_map(file_name)
		unless File.file?(file_name)
		 	raise IOError, "not found"
		end 
		file = File.open(file_name, "r")
		routes = file.read.split("\n")
		file.close
		routes.each do |route|
      words = route.split(", ")
      st1, ln1, st2, ln2, time = words
      id_1 = st1 + ln1
      id_2 = st2 + ln2
      unless @stations.has_key?(id_1)
        @stations[id_1] = Station.new(st1, ln1)
      end
      if st1 == st2
        @stations[id_1].add_transfer(@stations[id_2], time)
        @stations[id_2].add_transfer(@stations[id_1],time)
      else
        unless @stations.has_key?(id_2)
          @stations[id_2] = Station.new(st2, ln2)
        end
        @stations[id_1].add_connection(@stations[id_2], time)
        @stations[id_2].add_connection(@stations[id_1],time)
      end
    end
	rescue IOError => error
		puts "Error: File \"#{file}\" #{error.message}" 
  end

  # Finds the route from 'start' to 'finish' where user can make transfer at station 'route' if needed
  def find_route(start,finish,start_line,finish_line, visited, route, time)
    visited << start.name
    connection = start.connections.find {|connection| !visited.include?(connection.station.name)}
    raise ArgumentError if connection.nil?
    new_time = time + connection.time.to_f
    pass_station = connection.station
    unless start_line == finish_line
      transfer =  pass_station.transfers.find {|transfer| transfer.station.line == finish_line}
      unless transfer.nil?
        new_time = new_time + transfer.time.to_f
        route = transfer.station
        start_line = finish_line
        pass_station = transfer.station
      end
    end
    if pass_station.name == finish.name
      [new_time, route]
    else
      find_route(pass_station, finish, start_line, finish_line, visited, route, new_time)
    end
  end

  # Prints the found routes
  def print_routes

    # Get user start and destination
    print 'Provide the start of the trip: '
    start = $stdin.gets.chomp
    print 'Provide the end of the trip: '
    finish = $stdin.gets.chomp

    # Find the station in the list where user starts and finish his/her trip
    st1 = Array.new
    st2 = Array.new
    @stations.each do |key, value|
      if value.name == start
        st1 << value
      end
      if value.name == finish
        st2 << value
      end
    end

    # Print the route for each option
    option = 0
    st1.each do |s1|
      st2.each do |s2|
        begin
          time, switch = find_route(s1, s2, s1.line, s2.line, [], '', 0)
          if switch == ''
            puts 'Option %d (%0.1f mn) : At %s, take %s line exit at %s' % [option, time.to_f, s1.name, s1.line, s2.name]
          else
            puts 'Option %d (%0.1f mn) : At %s take %s line, change at %s and take %s line exit at %s' %
                     [option, time.to_f, s1.name, s1.line, switch.name, s2.line, s2.name]
          end
        rescue ArgumentError
          puts "No options found to go from #{s1} to #{s2} with maximum one change"
        end
      end
      option = option + 1
    end
  end
  private :find_route
end

class Change
  attr_accessor :station, :time
  def initialize(station, time)
    @station = station
    @time = time
  end
end

class Transfer < Change
end

class Connection < Change
end

class Station
	attr_accessor :name, :connections, :transfers, :line

	def initialize(name, line)
    @line = line
		@name = name
		@connections = Array.new
    @transfers = Array.new
  end

  def add_connection(station, time)
    @connections << Connection.new(station, time)
  end

  def add_transfer(station, time)
    @transfers << Transfer.new(station, time)
  end

  def to_s
    @name + " " + @line
  end

end

@metro = Metro.new
@metro.get_map("input.txt")
@metro.print_routes
